# javaScript

## ����

* ��������
* ����
* math��

js ������ʿ��Ʒǳ�����ֻ��ȫ����(global scope)��������(block scope)��֪��ES6��ʼ���п鼶������(block scope)
###  function


��������Ķ��ַ���

��������
��������
�������� ���ʽ
#### IIFE

�������ú��� IIFE(immediately invoked function expression)
����û�п鼶������ͨ����IIFE�ṩ��������棬��ֹ��Ⱦȫ�������ռ䡣
``` js
function foo(){
    var a=10;
    console.log(a);
}
foo(); // no IIFE 

// use IIFE
(function foo(){
    var a=10;
    console.log(a);
})();

```


Function���������Է���
����js�� �������ģ����еĺ������ǳ�Ա����������һ��thisָ�룬ȫ�ֺ�����thisָ��ָ��һ��ȫ��Ĭ�϶��󣬣�web�������ָ��windows����

call ��apply ��ʹ�÷�����
call �������� �������顣
apply�������� �����������롣
``` js
function myFunction(a,b){
    return a*b;
}
var myObject = myFunction.call(null,10,2);
var myObject2 = myFunction.apply(null,[10,2]);
```

``` js
function myFunction2(a){
    return a+this.b;
}
var obj={b:3,a:2};
var v3 = myFunction2.call(obj,10);

```

��ͷ����



## ����
* ��������
* filter

closure �հ�
�൱����״̬/��˽�г�Ա�����ĺ������൱��һ��ֻ��һ�������Ľ��ն���
�Ͷ����Ա�����������ǣ��հ��Ǻ�����λ�������Ա�����Ƕ���λ��
jsvascript�У��հ����������ڣ��������ɲ������ɱ�������ò�������ĸ�����������ʽ������php�к�����Ҫͨ��use��ʽ��������ı�����
�������ڽ���ִ��ʱ�����ֺ��������˷ǵ�ǰ��ı������͸�������Щ���������˱հ���
ע�⣺ �հ���ͺ����Ķ���λ����أ������λ���޹ء�



������ֻ�ܷ����Լ��ĳ�Ա������
``` JS
function f1(){
    var a = 0;
    return function inc(){
        console.log(a++);
    }
}
var _inc = f1();
_inc();
_inc();
var _inc2 = f1();
_inc2();

```

``` js
var obj = {
    count:0,
    inc:function(){
        return ++this.count;
    }
}
obj.inc();
obj.inc();
```

ͨ�����ϵ����ӶԱȿ��Է��֣�����Ч���൱�����հ���д����Ϊ���գ��Ͼ�`inc()`��  `obj.inc()`��
���ʹ����ʽ���ã��հ���̵��ص�����������
### let


``` js
for (var i=1;i<=5;i++){
    setTimeout(function timer(){
        console.log(i);
    },i*1000);
}

for (let i=1;i<=5;i++){
    setTimeout(function timer(){
        console.log(i);
    },i*1000); 
}

```



## misc

���ִ��js���룿

* �����url��ִ��js��`javascript:alert('hello from address bar :)');`,��Ҫ��ʽ���javascript:�����ס�
* ��chrome devTools��ѡ��consoleҳ�棬�����Խ���ʽ����ִ�д���



��׿�ֻ������Yandex����ͨ���ͺ�����װJS�ű����Ӷ�ʵ�ָ������ذٶ����ļ����ƽ�Bվ�޶��۰�̨����ۿ�����ѹۿ���Ѷ��������VIP��Ƶ�ȹ��ܡ�

data:text/html, <html contenteditable>

javascript �� ECMAScript ��DOM��BOM��ɣ�
BOM �����������DOM ���ĵ�����BOM����Ƕ����DOM����


##  scope
domain
scope
context
environment
