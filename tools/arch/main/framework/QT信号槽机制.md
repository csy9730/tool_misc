# QT信号槽机制

信号槽机制与回调函数功能上类似，但提供更灵活的绑定。
* 发出者，
* 发出者的发出信号
* 接收者,
* 接收者的触发动作函数
* 信号和槽的绑定

注意：不考虑匿名函数槽的情况下， 信号和槽是类所有（QMetaObject），都是唯一的（static 修饰的），发出者/接收者/绑定是属于实例（QObjectPrivate）.
一次绑定 对应的是 `Connection`， 一个信号可以绑定多个槽，所以对应 `ConnectionList`。一个object拥有多个槽，所以携带了 `QObjectConnectionListVector`

``` cpp
class Q_CORE_EXPORT QObjectPrivate : public QObjectData{
    struct Connection
    {
        QObject *sender;
        QObject *receiver;
        union {
            StaticMetaCallFunction callFunction;
            QtPrivate::QSlotObjectBase *slotObj;
        };
        Connection *nextConnectionList;
        Connection *next;
        Connection **prev;  
    };
    
    // ConnectionList is a singly-linked list
    struct ConnectionList {
        ConnectionList() : first(nullptr), last(nullptr) {}
        Connection *first;
        Connection *last;
    };
    class QObjectConnectionListVector : public QVector<QObjectPrivate::ConnectionList>{

    }
    struct Sender
    {
        QObject *sender;
        int signal;
        int ref;
    };

    void addConnection(int signal, Connection *c);
    QObjectConnectionListVector *connectionLists;
}

static QMetaObject::Connection QObject::connect(const typename QtPrivate::FunctionPointer<Func1>::Object *sender, Func1 signal,
                                     const typename QtPrivate::FunctionPointer<Func2>::Object *receiver, Func2 slot,
                                     Qt::ConnectionType type = Qt::AutoConnection)
{
    typedef QtPrivate::FunctionPointer<Func1> SignalType;
    typedef QtPrivate::FunctionPointer<Func2> SlotType;
    return connectImpl(sender, reinterpret_cast<void **>(&signal),
                        receiver, reinterpret_cast<void **>(&slot),
                        new QtPrivate::QSlotObject<Func2, typename QtPrivate::List_Left<typename SignalType::Arguments, SlotType::ArgumentCount>::Value,
                                        typename SignalType::ReturnType>(slot),
                        type, types, &SignalType::Object::staticMetaObject);
}
QMetaObject::Connection QObject::connectImpl(const QObject *sender, void **signal,
                                             const QObject *receiver, void **slot,
                                             QtPrivate::QSlotObjectBase *slotObj, Qt::ConnectionType type,
                                             const int *types, const QMetaObject *senderMetaObject)
{
    signal_index += QMetaObjectPrivate::signalOffset(senderMetaObject);
    return QObjectPrivate::connectImpl(sender, signal_index, receiver, slot, slotObj, type, types, senderMetaObject);
}

QMetaObject::Connection QObjectPrivate::connect(const typename QtPrivate::FunctionPointer<Func1>::Object *sender, Func1 signal,
                                                       const typename QtPrivate::FunctionPointer<Func2>::Object *receiverPrivate, Func2 slot,
                                                       Qt::ConnectionType type)
{
    return QObject::connectImpl(sender, reinterpret_cast<void **>(&signal),
    receiverPrivate->q_ptr, reinterpret_cast<void **>(&slot),
    new QtPrivate::QPrivateSlotObject<Func2, typename QtPrivate::List_Left<typename SignalType::Arguments, SlotType::ArgumentCount>::Value,
                                    typename SignalType::ReturnType>(slot),
    type, types, &SignalType::Object::staticMetaObject);
} 


QMetaObject::Connection QObjectPrivate::connectImpl(const QObject *sender, int signal_index,
                                             const QObject *receiver, void **slot,
                                             QtPrivate::QSlotObjectBase *slotObj, Qt::ConnectionType type,
                                             const int *types, const QMetaObject *senderMetaObject)
{
    QObject *s = const_cast<QObject *>(sender);
    QObject *r = const_cast<QObject *>(receiver);

    QOrderedMutexLocker locker(signalSlotLock(sender),
                               signalSlotLock(receiver));

    QScopedPointer<QObjectPrivate::Connection> c(new QObjectPrivate::Connection);
    c->sender = s;
    c->signal_index = signal_index;
    c->receiver = r;
    c->slotObj = slotObj;
    c->connectionType = type;
    c->isSlotObject = true;
    if (types) {
        c->argumentTypes.store(types);
        c->ownArgumentTypes = false;
    }

    QObjectPrivate::get(s)->addConnection(signal_index, c.data());
    QMetaObject::Connection ret(c.take());
    locker.unlock();

    QMetaMethod method = QMetaObjectPrivate::signal(senderMetaObject, signal_index);
    s->connectNotify(method);
    return ret;
}

void QObjectPrivate::addConnection(int signal, Connection *c){
    ConnectionList &connectionList = (*connectionLists)[signal];
}


```

大部分工作隐藏在 MOC之下，信号触发之后，搜索对应的object，获取。


``` cpp

struct Q_CORE_EXPORT QMetaObject
{
    class Connection;
    const char *className() const;
    const QMetaObject *superClass() const;

    bool inherits(const QMetaObject *metaObject) const Q_DECL_NOEXCEPT;
    QObject *cast(QObject *obj) const;
    const QObject *cast(const QObject *obj) const;


    int methodOffset() const;
    int enumeratorOffset() const;
    int propertyOffset() const;
    int classInfoOffset() const;

    int constructorCount() const;
    int methodCount() const;
    int enumeratorCount() const;
    int propertyCount() const;
    int classInfoCount() const;

    int indexOfConstructor(const char *constructor) const;
    int indexOfMethod(const char *method) const;
    int indexOfSignal(const char *signal) const;
    int indexOfSlot(const char *slot) const;
    int indexOfEnumerator(const char *name) const;
    int indexOfProperty(const char *name) const;
    int indexOfClassInfo(const char *name) const;

    QMetaMethod constructor(int index) const;
    QMetaMethod method(int index) const;
    QMetaEnum enumerator(int index) const;
    QMetaProperty property(int index) const;
    QMetaClassInfo classInfo(int index) const;
    QMetaProperty userProperty() const;

    static bool checkConnectArgs(const char *signal, const char *method);
    static bool checkConnectArgs(const QMetaMethod &signal,
                                 const QMetaMethod &method);
    static QByteArray normalizedSignature(const char *method);
    static QByteArray normalizedType(const char *type);

    // internal index-based connect
    static Connection connect(const QObject *sender, int signal_index,
                        const QObject *receiver, int method_index,
                        int type = 0, int *types = nullptr);
    // internal index-based disconnect
    static bool disconnect(const QObject *sender, int signal_index,
                           const QObject *receiver, int method_index);
    static bool disconnectOne(const QObject *sender, int signal_index,
                              const QObject *receiver, int method_index);
    // internal slot-name based connect
    static void connectSlotsByName(QObject *o);

    // internal index-based signal activation
    static void activate(QObject *sender, int signal_index, void **argv);
    static void activate(QObject *sender, const QMetaObject *, int local_signal_index, void **argv);
    static void activate(QObject *sender, int signal_offset, int local_signal_index, void **argv);

    static bool invokeMethod(QObject *obj, const char *member,
                             Qt::ConnectionType,
                             QGenericReturnArgument ret,
                             QGenericArgument val0 = QGenericArgument(nullptr),
                             QGenericArgument val1 = QGenericArgument(),
                             QGenericArgument val2 = QGenericArgument(),
                             QGenericArgument val3 = QGenericArgument(),
                             QGenericArgument val4 = QGenericArgument(),
                             QGenericArgument val5 = QGenericArgument(),
                             QGenericArgument val6 = QGenericArgument(),
                             QGenericArgument val7 = QGenericArgument(),
                             QGenericArgument val8 = QGenericArgument(),
                             QGenericArgument val9 = QGenericArgument());

    // invokeMethod() for member function pointer
    template <typename Func>
    static typename std::enable_if<QtPrivate::FunctionPointer<Func>::IsPointerToMemberFunction
                                   && !std::is_convertible<Func, const char*>::value
                                   && QtPrivate::FunctionPointer<Func>::ArgumentCount == 0, bool>::type
    invokeMethod(typename QtPrivate::FunctionPointer<Func>::Object *object,
                 Func function,
                 Qt::ConnectionType type = Qt::AutoConnection,
                 typename QtPrivate::FunctionPointer<Func>::ReturnType *ret = nullptr)
    {
        return invokeMethodImpl(object, new QtPrivate::QSlotObjectWithNoArgs<Func>(function), type, ret);
    }

    enum Call {
        InvokeMetaMethod,
        ReadProperty,
        WriteProperty,
        ResetProperty,
        QueryPropertyDesignable,
        QueryPropertyScriptable,
        QueryPropertyStored,
        QueryPropertyEditable,
        QueryPropertyUser,
        CreateInstance,
        IndexOfMethod,
        RegisterPropertyMetaType,
        RegisterMethodArgumentMetaType
    };

    int static_metacall(Call, int, void **) const;
    static int metacall(QObject *, Call, int, void **);
};
```


``` cpp
void Object::sig()
{
    MetaObject::active(this, 0);
}

void QMetaObject::activate(QObject *sender, const QMetaObject *m, int local_signal_index,
                           void **argv)
{
    activate(sender, QMetaObjectPrivate::signalOffset(m), local_signal_index, argv);
}


void QMetaObject::activate(QObject *sender, int signalOffset, int local_signal_index, void **argv)
{
    int signal_index = signalOffset + local_signal_index;

    if (sender->d_func()->blockSig)
        return;

    Q_TRACE_SCOPE(QMetaObject_activate, sender, signal_index);

    if (sender->d_func()->isDeclarativeSignalConnected(signal_index)
            && QAbstractDeclarativeData::signalEmitted) {
        Q_TRACE_SCOPE(QMetaObject_activate_declarative_signal, sender, signal_index);
        QAbstractDeclarativeData::signalEmitted(sender->d_func()->declarativeData, sender,
                                                signal_index, argv);
    }


    void *empty_argv[] = { nullptr };
    if (!argv)
        argv = empty_argv;

    if (qt_signal_spy_callback_set.signal_begin_callback != 0) {
        qt_signal_spy_callback_set.signal_begin_callback(sender, signal_index, argv);
    }

    {
    QMutexLocker locker(signalSlotLock(sender));
    struct ConnectionListsRef {
        QObjectConnectionListVector *connectionLists;
        ConnectionListsRef(QObjectConnectionListVector *connectionLists) : connectionLists(connectionLists)
        {
            if (connectionLists)
                ++connectionLists->inUse;
        }
        ~ConnectionListsRef()
        {
            if (!connectionLists)
                return;

            --connectionLists->inUse;
            Q_ASSERT(connectionLists->inUse >= 0);
            if (connectionLists->orphaned) {
                if (!connectionLists->inUse)
                    delete connectionLists;
            }
        }

        QObjectConnectionListVector *operator->() const { return connectionLists; }
    };

    ConnectionListsRef connectionLists = sender->d_func()->connectionLists;
    if (!connectionLists.connectionLists) {
        locker.unlock();
        if (qt_signal_spy_callback_set.signal_end_callback != 0)
            qt_signal_spy_callback_set.signal_end_callback(sender, signal_index);
        return;
    }

    const QObjectPrivate::ConnectionList *list;
    if (signal_index < connectionLists->count())
        list = &connectionLists->at(signal_index);
    else
        list = &connectionLists->allsignals;

    Qt::HANDLE currentThreadId = QThread::currentThreadId();

    do {
        QObjectPrivate::Connection *c = list->first;
        if (!c) continue;
        // We need to check against last here to ensure that signals added
        // during the signal emission are not emitted in this emission.
        QObjectPrivate::Connection *last = list->last;

        do {
            if (!c->receiver)
                continue;

            QObject * const receiver = c->receiver;
            const bool receiverInSameThread = currentThreadId == receiver->d_func()->threadData->threadId.load();

            // determine if this connection should be sent immediately or
            // put into the event queue
            if ((c->connectionType == Qt::AutoConnection && !receiverInSameThread)
                || (c->connectionType == Qt::QueuedConnection)) {
                queued_activate(sender, signal_index, c, argv, locker);
                continue;
#if QT_CONFIG(thread)
            } else if (c->connectionType == Qt::BlockingQueuedConnection) {
                if (receiverInSameThread) {
                    qWarning("Qt: Dead lock detected while activating a BlockingQueuedConnection: "
                    "Sender is %s(%p), receiver is %s(%p)",
                    sender->metaObject()->className(), sender,
                    receiver->metaObject()->className(), receiver);
                }
                QSemaphore semaphore;
                QMetaCallEvent *ev = c->isSlotObject ?
                    new QMetaCallEvent(c->slotObj, sender, signal_index, 0, 0, argv, &semaphore) :
                    new QMetaCallEvent(c->method_offset, c->method_relative, c->callFunction, sender, signal_index, 0, 0, argv, &semaphore);
                QCoreApplication::postEvent(receiver, ev);
                locker.unlock();
                semaphore.acquire();
                locker.relock();
                continue;
#endif
            }

            QConnectionSenderSwitcher sw;

            if (receiverInSameThread) {
                sw.switchSender(receiver, sender, signal_index);
            }
            if (c->isSlotObject) {
                c->slotObj->ref();
                QScopedPointer<QtPrivate::QSlotObjectBase, QSlotObjectBaseDeleter> obj(c->slotObj);
                locker.unlock();

                {
                    Q_TRACE_SCOPE(QMetaObject_activate_slot_functor, obj.data());
                    obj->call(receiver, argv);
                }

                // Make sure the slot object gets destroyed before the mutex is locked again, as the
                // destructor of the slot object might also lock a mutex from the signalSlotLock() mutex pool,
                // and that would deadlock if the pool happens to return the same mutex.
                obj.reset();

                locker.relock();
            } else if (c->callFunction && c->method_offset <= receiver->metaObject()->methodOffset()) {
                //we compare the vtable to make sure we are not in the destructor of the object.
                const int methodIndex = c->method();
                const int method_relative = c->method_relative;
                const auto callFunction = c->callFunction;
                locker.unlock();
                if (qt_signal_spy_callback_set.slot_begin_callback != 0)
                    qt_signal_spy_callback_set.slot_begin_callback(receiver, methodIndex, argv);

                {
                    Q_TRACE_SCOPE(QMetaObject_activate_slot, receiver, methodIndex);
                    callFunction(receiver, QMetaObject::InvokeMetaMethod, method_relative, argv);
                }

                if (qt_signal_spy_callback_set.slot_end_callback != 0)
                    qt_signal_spy_callback_set.slot_end_callback(receiver, methodIndex);
                locker.relock();
            } else {
                const int method = c->method_relative + c->method_offset;
                locker.unlock();

                if (qt_signal_spy_callback_set.slot_begin_callback != 0) {
                    qt_signal_spy_callback_set.slot_begin_callback(receiver, method, argv);
                }

                {
                    Q_TRACE_SCOPE(QMetaObject_activate_slot, receiver, method);
                    metacall(receiver, QMetaObject::InvokeMetaMethod, method, argv);
                }

                if (qt_signal_spy_callback_set.slot_end_callback != 0)
                    qt_signal_spy_callback_set.slot_end_callback(receiver, method);

                locker.relock();
            }

            if (connectionLists->orphaned)
                break;
        } while (c != last && (c = c->nextConnectionList) != 0);

        if (connectionLists->orphaned)
            break;
    } while (list != &connectionLists->allsignals &&
        //start over for all signals;
        ((list = &connectionLists->allsignals), true));

    }

    if (qt_signal_spy_callback_set.signal_end_callback != 0)
        qt_signal_spy_callback_set.signal_end_callback(sender, signal_index);
}

```



## callback
其实回调、委托、通知、监听、广播等本质上是一样的，只是不同语言的不同实现用不同的术语来表达。

callback 一词本来用于打电话。你可以打电话（call）给别人，也可以留下电话号码，让别人回电话（callback）。计算机领域相对较新，一些日常词汇被引进，表达类似概念。call 和 callback 在计算机领域翻译成“调用”和“回调”。
回调函数是你写一个函数，让预先写好的系统来调用。你调用系统的函数，是直调。让系统调用你的函数，就是回调。但假如满足于这种一句话结论，是不会真正明白回调的应用场景。

回调函数可以看成，有两个主体，交互完成任务。
A 让 B 做事，根据粒度不同，可以理解成 A 函数调用 B 函数，或者 A 类使用 B 类，或者 A 组件使用 B 组件，或者A应用调用B系统库等等。反正就是 A 叫 B 做事（call）。
当B做这件事情的时候，会发现B自己靠自己无法完成，有些东西一定是A配合才能完成的。就需要 A 从外面传进来，或者 B 做着做着再向外面申请。对于 B 来说，一种被动得到信息，一种是主动去得到信息。有些人给这两种方式一个术语，叫信息的压送（ push），和信息的拉取（ pull）。

例如，A委托B帮他买东西，B打开淘宝，挑选东西放入购物车，推送到A眼前，由A来完成支付



### demo
回调函数概念： 包括 调用函数，回调函数，调用环境。回调函数概念用于描述两个个体/两个层次之间的交互，重点在于单个个体无法单独完成函数功能，需要两个个体/层次交互完成
1. 注册回调函数
2. 使用回调函数

``` python
def fSave(x):
    with open('foo.json', 'w') as fp:
        json.dump(x, fp)

class A:
    def __init__(self, f):
        self._f = f
    def add(self, x):
        self._f(x + 1)

# binding
a=A(fSave)

# call
a.add(3)

```

## misc
[https://github.com/NoAvailableAlias/nano-signal-slot](https://github.com/NoAvailableAlias/nano-signal-slot)