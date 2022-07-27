# Python treelib库创建多叉树的用法介绍

treelib 库是一个 Python 的第三方库。这个库实现了一些多叉树相关的常用方法。

### **一、安装treelib**

在 treelib 库中，实现了两个类 Tree 和 Node，分别用于创建多叉树和创建节点。

### **二、创建多叉树和添加节点**

#### 1. 创建一棵多叉树

```python
# coding=utf-8
from treelib import Tree, Node


tree = Tree()
tree.show()
print(tree.identifier)
```

运行结果：

```
Tree is empty

2f9fa5c8-e7aa-11ea-9b8b-b886873e4844
```

Tree 类用于实例化一棵多叉树。有四个初始化参数(tree=None, deep=False, node\_class=None, identifier=None)，都有默认值。tree表示拷贝一棵已有的树，传入一个Tree的对象。deep表示拷贝另一棵树时是否深拷贝。node\_class表示节点类，一般不需要使用，可以不管。identifier表示树的id，在初始化时会默认分配一个唯一的id值，也可以手动指定一个id，保证是唯一的就行，树一旦创建完成，id就不能再修改。

#### 2. 添加节点到多叉树中

```python
tree.create_node(tag='Node-5', identifier='node-5', data=5)
tree.create_node(tag='Node-10', identifier='node-10', parent='node-5', data=10)
tree.create_node('Node-15', 'node-15', 'node-10', 15)
tree.show()

node = Node(data=50)
tree.add_node(node, parent='node-5')
node_a = Node(tag='Node-A', identifier='node-A', data='A')
tree.add_node(node_a, parent='node-5')
tree.show()
```

运行结果：

```
Node-5
└── Node-10
    └── Node-15

Node-5
├── Node-10
│   └── Node-15
├── Node-A
└── ddeb9b02-e7ab-11ea-b2ee-b886873e4844
```

create\_node(tag=None, identifier=None, parent=None, data=None): 创建一个节点并直接添加到树中。tag表示节点的标签，在控制台打印树的结构时显示的就是节点的标签，可以指定值，如果不指定值则默认等于id。identifier表示节点的id，默认会分配一个唯一的id，也可以指定一个唯一id。这里要注意，id是唯一的，不能重复，标签是可以重复的但最好别重复。parent表示节点的父节点，根节点可以不指定，不过，一棵树只能有一个根节点，如果树中已经有根节点了，parent还为空会报错。data表示节点中保存的数据，可以是各种数据类型。

add\_node(node, parent=None): 添加一个节点到树中。这个方法需要先用 Node 类创建好节点，第一个参数传入节点，第二参数同create\_node()方法。

### **三、Node创建节点和Node类中的方法**

#### 1\. 创建节点

Node 类用于创建节点，有四个初始化参数(tag=None, identifier=None, expanded=True, data=None)，都有默认值。tag、identifier和data同前面的create\_node()方法。expanded表示节点的可扩展性，在 Tree 中会使用到，可以不用管，保持默认就行。

Node 类创建节点一般和 Tree 类中的add\_node()配合使用。

#### 2\. 节点的属性和方法

```python
print(node)
print('node id: ', node.identifier)
print('node tag:', node.tag)
print('node data:', node.data)

print('node is leaf: ', node.is_leaf())
print('node is root: ', node.is_root())
```

运行结果：

```
Node(tag=719f3842-e7af-11ea-8caa-b886873e4844, identifier=719f3842-e7af-11ea-8caa-b886873e4844, data=50)
node id:  719f3842-e7af-11ea-8caa-b886873e4844
node tag: 719f3842-e7af-11ea-8caa-b886873e4844
node data: 50
node is leaf:  True
node is root:  False
```

直接打印节点，会将节点作为一个类对象打印出来。节点的tag、identifier和data三条属性可以单独调用，可以看到在不指定值时，tag与identifier相等，是一个系统分配的唯一值。

is\_leaf(tree\_id=None): 返回节点在树中的位置是不是叶节点。

is\_root(tree\_id=None): 返回节点在树中的位置是不是根节点。

Node 类中还有一些其他的方法，主要用于对节点的指针作处理，一般不会直接调用，这里就不介绍了。

### **四、Tree中的方法介绍**

#### 1\. 返回多叉树中的节点个数

```python
tree.show()
print('tree len: ', len(tree))
print('tree size:', tree.size())
tree.create_node(tag='Node-20', identifier='node-20', parent='node-10', data=20)
tree.create_node(tag='Node-30', identifier='node-30', parent='node-15', data=30)
print('tree size:', tree.size())
```

运行结果：

```
Node-5
├── 6e75a77a-e92d-11ea-abfe-b886873e4844
├── Node-10
│   └── Node-15
└── Node-A

tree len:  5
tree size: 5
tree size: 7
```

show(): 将多叉树按树形结构展示输出。可以传入相关参数来限定展示的范围。

size(level=None): 返回多叉树的节点个数，默认返回多叉树中的所有节点，与len()方法相同。如果指定层数level，则只返回该层的节点个数。

#### 2\. 返回多叉树中的节点

```python
tree.show()
print(tree.all_nodes())
for node in tree.all_nodes_itr():
    print(node)
for id in tree.expand_tree():
    print(id)
```

运行结果：

```
Node-5
├── Node-10
│   ├── Node-15
│   │   └── Node-30
│   └── Node-20
├── Node-A
└── fcb7619a-e931-11ea-8946-b886873e4844

[Node(tag=Node-5, identifier=node-5, data=5), Node(tag=Node-10, identifier=node-10, data=10), Node(tag=Node-15, identifier=node-15, data=15), Node(tag=fcb7619a-e931-11ea-8946-b886873e4844, identifier=fcb7619a-e931-11ea-8946-b886873e4844, data=50), Node(tag=Node-A, identifier=node-A, data=A), Node(tag=Node-20, identifier=node-20, data=20), Node(tag=Node-30, identifier=node-30, data=30)]
Node(tag=Node-5, identifier=node-5, data=5)
Node(tag=Node-10, identifier=node-10, data=10)
Node(tag=Node-15, identifier=node-15, data=15)
Node(tag=fcb7619a-e931-11ea-8946-b886873e4844, identifier=fcb7619a-e931-11ea-8946-b886873e4844, data=50)
Node(tag=Node-A, identifier=node-A, data=A)
Node(tag=Node-20, identifier=node-20, data=20)
Node(tag=Node-30, identifier=node-30, data=30)
node-5
node-10
node-15
node-30
node-20
node-A
fcb7619a-e931-11ea-8946-b886873e4844
```

all\_nodes(): 返回多叉树中的所有节点，返回结果是一个节点对象构成的列表，节点的顺序是添加到树中的顺序。

all\_nodes\_itr(): 返回多叉树中的所有节点，返回结果是一个迭代器，节点的顺序是添加到树中的顺序。

expand\_tree(): 返回多叉树中的所有节点id，返回结果是一个生成器，顺序是按深度优先遍历的顺序。可以传入过滤条件等参数来改变返回的生成器。

#### 3\. 多叉树中的节点关系

```python
print('node-5 children:', tree.children('node-5'))
print('node-10 branch:', tree.is_branch('node-10'))
print('node-20 siblings:', tree.siblings('node-20'))
print('node-30 parent:', tree.parent('node-30'))
print('node-15 ancestor: ', tree.ancestor('node-15'))
print(tree.is_ancestor('node-15', 'node-30'))
for node in tree.rsearch('node-30'):
    print(node)
```

运行结果：

```
node-5 children: [Node(tag=Node-10, identifier=node-10, data=10), Node(tag=2fbce8a8-e933-11ea-9304-b886873e4844, identifier=2fbce8a8-e933-11ea-9304-b886873e4844, data=50), Node(tag=Node-A, identifier=node-A, data=A)]
node-10 branch: ['node-15', 'node-20']
node-20 siblings: [Node(tag=Node-15, identifier=node-15, data=15)]
node-30 parent: Node(tag=Node-15, identifier=node-15, data=15)
node-15 ancestor:  node-10
True
node-30
node-15
node-10
node-5
```

children(nid): 传入节点id，返回节点的所有子节点，返回结果是一个节点列表，如果没有子节点则返回空列表。

is\_branch(nid): 传入节点id，返回节点的所有子节点id，返回结果是一个列表，如果没有子节点则返回空列表。

siblings(nid): 传入节点id，返回节点的所有兄弟节点，返回结果是一个节点列表，如果没有兄弟节点则返回空列表。

parent(nid): 传入节点id，返回节点的父节点，如果传入的是根节点，则返回None。

ancestor(nid, level=None): 传入节点id，返回节点的一个祖先节点，如果指定level则返回level层的祖先节点，如果不指定level则返回父节点，如果指定level比节点的层数大，则报错。

is\_ancestor(ancestor, grandchild): 传入两个节点id，判断ancestor是不是grandchild的祖先，返回布尔值。

rsearch(nid, filter=None): 传入节点id，遍历节点到根节点的路径上的所有节点id，包含该节点和根节点，返回结果是一个生成器。可以传入过滤条件对结果进行过滤。

#### 4\. 多叉树的深度和叶子节点

```python
print('tree depth:', tree.depth())
print('node-20 depth:', tree.depth(node='node-20'))
print('node-20 level:', tree.level('node-20'))
print('tree leaves:', tree.leaves())
print(tree.paths_to_leaves())
```

运行结果：

```
tree depth: 3
node-20 depth: 2
node-20 level: 2
tree leaves: [Node(tag=7e421cb4-e935-11ea-8e6d-b886873e4844, identifier=7e421cb4-e935-11ea-8e6d-b886873e4844, data=50), Node(tag=Node-A, identifier=node-A, data=A), Node(tag=Node-20, identifier=node-20, data=20), Node(tag=Node-30, identifier=node-30, data=30)]
[['node-5', '7e421cb4-e935-11ea-8e6d-b886873e4844'], ['node-5', 'node-A'], ['node-5', 'node-10', 'node-20'], ['node-5', 'node-10', 'node-15', 'node-30']]
```

depth(node=None): 返回节点的高度，根节点高度为0，依次递增。如果不指定节点则返回树的高度。

level(nid, filter=None): 返回节点的高度，level()与depth()的结果相同，只是传参方式不一样。

leaves(nid=None): 返回多叉树的所有叶节点，返回结果是一个节点列表。不指定节点id时，默认返回整棵树的所有叶节点，指定节点id时，返回以指定节点作为根节点的子树的所有叶节点。

paths\_to\_leaves(): 返回根节点到每个叶节点的路径上的所有节点id，每个叶节点的结果是一个列表，所有叶节点的结果又组成一个列表。所以最终结果是列表嵌套列表。

#### 5\. 判断节点是否在多叉树中和获取节点

```python
print('node-10 is in tree:', tree.contains('node-10'))
print('node-100 is in tree:', tree.contains('node-100'))
print(tree.get_node('node-10'))
print(tree.get_node('node-100'))
tree.update_node('node-20', data=200)
print('data of node-20:', tree.get_node('node-20').data)
```

运行结果：

```
node-10 is in tree: True
node-100 is in tree: False
Node(tag=Node-10, identifier=node-10, data=10)
None
data of node-20: 200
```

contains(nid): 传入节点id，判断节点是否在树中，返回布尔值。

get\_node(nid): 传入节点id，从树中获取节点，返回节点对象，如果传入的节点id不在树中则返回None。

update\_node(nid, \*\*attrs): 传入节点id，修改节点的属性值，需要修改哪个参数就用关键字参数的方式传入，可以传入0个或多个属性。

#### 6\. 调整多叉树中的节点关系

```python
tree.show()
tree.link_past_node('node-10')
tree.show()
tree.move_node('node-30', 'node-20')
tree.show()
```

运行结果：

```
Node-5
├── 488e66b6-e939-11ea-aa02-b886873e4844
├── Node-10
│   ├── Node-15
│   │   └── Node-30
│   └── Node-20
└── Node-A

Node-5
├── 488e66b6-e939-11ea-aa02-b886873e4844
├── Node-15
│   └── Node-30
├── Node-20
└── Node-A

Node-5
├── 488e66b6-e939-11ea-aa02-b886873e4844
├── Node-15
├── Node-20
│   └── Node-30
└── Node-A
```

link\_past\_node(nid): 传入节点id，将该节点的所有子节点都链接到它的父节点上，相当于将该节点从树中删除。如果节点id不在树中则报错。

move\_node(source, destination): 传入两个节点id，将source节点移动成为destination节点的子节点。如果节点id不在树中则报错。

#### 7\. 多叉树的合并和子树拷贝

```python
tree2 = Tree()
tree2.create_node(tag='Node-7', identifier='node-7', data=7)
tree2.create_node(tag='Node-17', identifier='node-17', parent='node-7', data=17)
tree2.show()
tree.paste('node-20', tree2)
tree.show()

tree3 = Tree()
tree3.create_node(tag='Node-8', identifier='node-8', data=8)
tree3.create_node(tag='Node-18', identifier='node-18', parent='node-8', data=18)
tree3.show()
tree.merge('node-A', tree3)
tree.show()

print(tree.subtree('node-20'))
```

运行结果：

```
Node-7
└── Node-17

Node-5
├── 4f603236-e93a-11ea-8577-b886873e4844
├── Node-15
├── Node-20
│   ├── Node-30
│   └── Node-7
│       └── Node-17
└── Node-A

Node-8
└── Node-18

Node-5
├── 4f603236-e93a-11ea-8577-b886873e4844
├── Node-15
├── Node-20
│   ├── Node-30
│   └── Node-7
│       └── Node-17
└── Node-A
    └── Node-18

Node-20
├── Node-30
└── Node-7
    └── Node-17
```

paste(nid, new\_tree, deep=False): 传入节点id和一棵新树，将整棵新树粘贴成为指定节点的子树，新树的根节点成为指定节点的子节点。如果节点不在树中则报错。

merge(nid, new\_tree, deep=False): 传入节点id和一棵新树，将新树与指定节点进行合并，合并后新树的根节点不保留，新树中根节点的子树全部成为指定节点的子树。如果节点不在树中则报错。

subtree(nid, identifier=None): 传入节点id，拷贝以该节点作为根节点的子树。如果节点不在树中则报错。

#### 8\. 多叉树转换成字典和保存到文件中

```python
print(tree.to_dict())
print(tree.to_json())
tree.to_graphviz()
tree.save2file('demo_tree.tree')
```

运行结果：

```
{'Node-5': {'children': ['Node-15', {'Node-20': {'children': ['Node-30', {'Node-7': {'children': ['Node-17']}}]}}, {'Node-A': {'children': ['Node-18']}}, 'e1f2ba34-e93b-11ea-a5f9-b886873e4844']}}
{"Node-5": {"children": ["Node-15", {"Node-20": {"children": ["Node-30", {"Node-7": {"children": ["Node-17"]}}]}}, {"Node-A": {"children": ["Node-18"]}}, "e1f2ba34-e93b-11ea-a5f9-b886873e4844"]}}
digraph tree {
  "node-5" [label="Node-5", shape=circle]
  "node-15" [label="Node-15", shape=circle]
  "node-20" [label="Node-20", shape=circle]
  "node-A" [label="Node-A", shape=circle]
  "e1f2ba34-e93b-11ea-a5f9-b886873e4844" [label="e1f2ba34-e93b-11ea-a5f9-b886873e4844", shape=circle]
  "node-30" [label="Node-30", shape=circle]
  "node-7" [label="Node-7", shape=circle]
  "node-18" [label="Node-18", shape=circle]
  "node-17" [label="Node-17", shape=circle]
  "node-5" -> "e1f2ba34-e93b-11ea-a5f9-b886873e4844"
  "node-5" -> "node-A"
  "node-5" -> "node-15"
  "node-5" -> "node-20"
  "node-20" -> "node-30"
  "node-20" -> "node-7"
  "node-A" -> "node-18"
  "node-7" -> "node-17"
}
```

to\_dict(): 将树转换成字典结构，兄弟节点用列表表示成并列关系，父子节点用字典表示成键值关系。最后将转换结果返回。

to\_json(): 将树转化成json，数据的结构与to\_dict()的相同，只是格式不一样。最后将转换结果返回。

to\_graphviz(): 将树转化成可视化图形的结构，无返回值。

save2file(filename): 将树保存到一个指定文件中，运行后会在当前路径下生成一个filename文件，在文件中写入树的结构图，同名文件存在时会追加写入，不会覆盖。

这四个方法都有很多关键字参数，可以指定参数来改变转化的结果。

#### 9\. 多叉树删除子树

```python
tree.show()
print('remover node: ', tree.remove_node('node-7'))
tree.show()
print(tree.remove_subtree('node-20'))
tree.show()
```

运行结果：

```
Node-5
├── 9e0bce40-e93d-11ea-99e7-b886873e4844
├── Node-15
├── Node-20
│   ├── Node-30
│   └── Node-7
│       └── Node-17
└── Node-A
    └── Node-18

remover node:  2
Node-5
├── 9e0bce40-e93d-11ea-99e7-b886873e4844
├── Node-15
├── Node-20
│   └── Node-30
└── Node-A
    └── Node-18

Node-20
└── Node-30

Node-5
├── 9e0bce40-e93d-11ea-99e7-b886873e4844
├── Node-15
└── Node-A
    └── Node-18
```

remove\_node(identifier): 传入节点id，将该节点作为根节点的子树删除，返回删除节点的个数。

remove\_subtree(nid, identifier=None): 传入节点id，将该节点作为根节点的子树删除，返回删除的子树。