# 二叉排序树(BST)原理与实现

[![过河卒](https://pic1.zhimg.com/v2-d0a881f4111fd112658f5b0ba269a2bd_xs.jpg?source=172ae18b)](https://www.zhihu.com/people/guo-he-zu-13-62)

[过河卒](https://www.zhihu.com/people/guo-he-zu-13-62)

https://atticuslab.com



5 人赞同了该文章

> *二叉排序树(Binary Sort Tree,BST)又称为二叉查找树、二叉搜索树。与树型查找有关的结构有二叉排序树，平衡二叉树，红黑树，B树，键树等。*

### 二叉树排序树性质

- 如果左子树不为空，则左子树上所有结点的值均小于根结点的值。
- 如果右子树不为空，则右子树上所有结点的值均大于根结点的值。
- 左、右子树也分别为二叉排序树。
- 树中没有值相同的结点。(????)

如果用中序遍历来遍历二叉排序树，则遍历结果是一个递增的序列。

### 查找性能分析

与折半查找类似，查找过程中和关键字比较的次数不超过树的深度。当二叉排序树形态比较对称，此时与折半查找相似，时间复杂度为O(log2n)，最坏情况下二叉排序树是一颗单树(只有左子树或只有右子树)，时间复杂度为O(n)。

### 二叉排序树实现

### bstree.h

```c
#ifndef _BINARY_SEARCH_TREE_H_
#define _BINARY_SEARCH_TREE_H_
typedef int Type;
typedef struct BSTreeNode{
    Type   key;                    // 关键字(键值)
 struct BSTreeNode *left;    // 左孩子
 struct BSTreeNode *right;    // 右孩子
 struct BSTreeNode *parent;    // 父结点
}Node, *BSTree;
// 前序遍历"二叉树"
void preorder_bstree(BSTree tree);
// 中序遍历"二叉树"
void inorder_bstree(BSTree tree);
// 后序遍历"二叉树"
void postorder_bstree(BSTree tree);
// (递归实现)查找"二叉树x"中键值为key的节点
Node* bstree_search(BSTree x, Type key);
// (非递归实现)查找"二叉树x"中键值为key的节点
Node* iterative_bstree_search(BSTree x, Type key);
// 查找最小结点：返回tree为根结点的二叉树的最小结点。
Node* bstree_minimum(BSTree tree);
// 查找最大结点：返回tree为根结点的二叉树的最大结点。
Node* bstree_maximum(BSTree tree);
// 找结点(x)的后继结点。即，查找"二叉树中数据值大于该结点"的"最小结点"。
Node* bstree_successor(Node *x);
// 找结点(x)的前驱结点。即，查找"二叉树中数据值小于该结点"的"最大结点"。
Node* bstree_predecessor(Node *x);
// 将结点插入到二叉树中，并返回根节点
Node* insert_bstree(BSTree tree, Type key);
// 删除结点(key为节点的值)，并返回根节点
Node* delete_bstree(BSTree tree, Type key);
// 销毁二叉树
void destroy_bstree(BSTree tree);
// 打印二叉树
void print_bstree(BSTree tree, Type key, int direction);
#endif
```

### bstree.c

```c
#include <stdio.h>
#include <stdlib.h>
#include "bstree.h"
/*
 * 前序遍历"二叉树"
 */
void preorder_bstree(BSTree tree)
{
 if(tree != NULL)
 {
 printf("%d ", tree->key);
 preorder_bstree(tree->left);
 preorder_bstree(tree->right);
 }
}
/*
 * 中序遍历"二叉树"
 */
void inorder_bstree(BSTree tree)
{
 if(tree != NULL)
 {
 inorder_bstree(tree->left);
 printf("%d ", tree->key);
 inorder_bstree(tree->right);
 }
}
/*
 * 后序遍历"二叉树"
 */
void postorder_bstree(BSTree tree)
{
 if(tree != NULL)
 {
 postorder_bstree(tree->left);
 postorder_bstree(tree->right);
 printf("%d ", tree->key);
 }
}
/*
 * (递归实现)查找"二叉树x"中键值为key的节点
 */
Node* bstree_search(BSTree x, Type key)
{
 if (x==NULL || x->key==key)
 return x;
 if (key < x->key)
 return bstree_search(x->left, key);
 else
 return bstree_search(x->right, key);
}
/*
 * (非递归实现)查找"二叉树x"中键值为key的节点
 */
Node* iterative_bstree_search(BSTree x, Type key)
{
 while ((x!=NULL) && (x->key!=key))
 {
 if (key < x->key)
            x = x->left;
 else
            x = x->right;
 }
 return x;
}
/* 
 * 查找最小结点：返回tree为根结点的二叉树的最小结点。
 */
Node* bstree_minimum(BSTree tree)
{
 if (tree == NULL)
 return NULL;
 while(tree->left != NULL)
        tree = tree->left;
 return tree;
}
/* 
 * 查找最大结点：返回tree为根结点的二叉树的最大结点。
 */
Node* bstree_maximum(BSTree tree)
{
 if (tree == NULL)
 return NULL;
 while(tree->right != NULL)
        tree = tree->right;
 return tree;
}
/* 
 * 找结点(x)的后继结点。即，查找"二叉树中数据值大于该结点"的"最小结点"。
 */
Node* bstree_successor(Node *x)
{
  // 如果x存在右孩子，则"x的后继结点"为 "以其右孩子为根的子树的最小结点"。
 if (x->right != NULL)
 return bstree_minimum(x->right);
  // 如果x没有右孩子。则x有以下两种可能：
  // (01) x是"一个左孩子"，则"x的后继结点"为 "它的父结点"。
  // (02) x是"一个右孩子"，则查找"x的最低的父结点，并且该父结点要具有左孩子"，找到的这个"最低的父结点"就是"x的后继结点"。
    Node* y = x->parent;
 while ((y!=NULL) && (x==y->right))
 {
        x = y;
        y = y->parent;
 }
 return y;
}
/* 
 * 找结点(x)的前驱结点。即，查找"二叉树中数据值小于该结点"的"最大结点"。
 */
Node* bstree_predecessor(Node *x)
{
  // 如果x存在左孩子，则"x的前驱结点"为 "以其左孩子为根的子树的最大结点"。
 if (x->left != NULL)
 return bstree_maximum(x->left);
  // 如果x没有左孩子。则x有以下两种可能：
  // (01) x是"一个右孩子"，则"x的前驱结点"为 "它的父结点"。
  // (01) x是"一个左孩子"，则查找"x的最低的父结点，并且该父结点要具有右孩子"，找到的这个"最低的父结点"就是"x的前驱结点"。
    Node* y = x->parent;
 while ((y!=NULL) && (x==y->left))
 {
        x = y;
        y = y->parent;
 }
 return y;
}
/*
 * 创建并返回二叉树结点。
 *
 * 参数说明：
 *     key 是键值。
 *     parent 是父结点。
 *     left 是左孩子。
 *     right 是右孩子。
 */
static Node* create_bstree_node(Type key, Node *parent, Node *left, Node* right)
{
    Node* p;
 if ((p = (Node *)malloc(sizeof(Node))) == NULL)
 return NULL;
    p->key = key;
    p->left = left;
    p->right = right;
    p->parent = parent;
 return p;
}
/* 
 * 将结点插入到二叉树中
 *
 * 参数说明：
 *     tree 二叉树的根结点
 *     z 插入的结点
 * 返回值：
 *     根节点
 */
static Node* bstree_insert(BSTree tree, Node *z)
{
    Node *y = NULL;
    Node *x = tree;
  // 查找z的插入位置
 while (x != NULL)
 {
        y = x;
 if (z->key < x->key)
            x = x->left;
 else
            x = x->right;
 }
    z->parent = y;
 if (y==NULL)
        tree = z;
 else if (z->key < y->key)
        y->left = z;
 else
        y->right = z;
 return tree;
}
/* 
 * 新建结点(key)，并将其插入到二叉树中
 *
 * 参数说明：
 *     tree 二叉树的根结点
 *     key 插入结点的键值
 * 返回值：
 *     根节点
 */
Node* insert_bstree(BSTree tree, Type key)
{
    Node *z;    // 新建结点
  // 如果新建结点失败，则返回。
 if ((z=create_bstree_node(key, NULL, NULL, NULL)) == NULL)
 return tree;
 return bstree_insert(tree, z);
}
/* 
 * 删除结点(z)，并返回根节点
 *
 * 参数说明：
 *     tree 二叉树的根结点
 *     z 删除的结点
 * 返回值：
 *     根节点
 */
static Node* bstree_delete(BSTree tree, Node *z)
{
    Node *x=NULL;
    Node *y=NULL;
 if ((z->left == NULL) || (z->right == NULL) )
        y = z;
 else
        y = bstree_successor(z);
 if (y->left != NULL)
        x = y->left;
 else
        x = y->right;
 if (x != NULL)
        x->parent = y->parent;
 if (y->parent == NULL)
        tree = x;
 else if (y == y->parent->left)
        y->parent->left = x;
 else
        y->parent->right = x;
 if (y != z) 
        z->key = y->key;
 if (y!=NULL)
 free(y);
 return tree;
}
/* 
 * 删除结点(key为节点的键值)，并返回根节点
 *
 * 参数说明：
 *     tree 二叉树的根结点
 *     z 删除的结点
 * 返回值：
 *     根节点
 */
Node* delete_bstree(BSTree tree, Type key)
{
    Node *z, *node; 
 if ((z = bstree_search(tree, key)) != NULL)
        tree = bstree_delete(tree, z);
 return tree;
}
/*
 * 销毁二叉树
 */
void destroy_bstree(BSTree tree)
{
 if (tree==NULL)
 return ;
 if (tree->left != NULL)
 destroy_bstree(tree->left);
 if (tree->right != NULL)
 destroy_bstree(tree->right);
 free(tree);
}
/*
 * 打印"二叉树"
 *
 * tree       -- 二叉树的节点
 * key        -- 节点的键值 
 * direction  --  0，表示该节点是根节点;
 *               -1，表示该节点是它的父结点的左孩子;
 *                1，表示该节点是它的父结点的右孩子。
 */
void print_bstree(BSTree tree, Type key, int direction)
{
 if(tree != NULL)
 {
 if(direction==0)  // tree是根节点
 printf("%2d is root\n", tree->key);
 else  // tree是分支节点
 printf("%2d is %2d's %6s child\n", tree->key, key, direction==1?"right" : "left");
 print_bstree(tree->left, tree->key, -1);
 print_bstree(tree->right,tree->key,  1);
 }
}
```

### main.c

```c
#include <stdio.h>
#include "bstree.h"
static int arr[]= {1,5,4,3,2,6};
#define TBL_SIZE(a) ( (sizeof(a)) / (sizeof(a[0])) )
void main()
{
 int i, ilen;
    BSTree root=NULL;
 printf("== 依次添加: ");
    ilen = TBL_SIZE(arr);
 for(i=0; i<ilen; i++)
 {
 printf("%d ", arr[i]);
        root = insert_bstree(root, arr[i]);
 }
 printf("\n== 前序遍历: ");
 preorder_bstree(root);
 printf("\n== 中序遍历: ");
 inorder_bstree(root);
 printf("\n== 后序遍历: ");
 postorder_bstree(root);
 printf("\n");
 printf("== 最小值: %d\n", bstree_minimum(root)->key);
 printf("== 最大值: %d\n", bstree_maximum(root)->key);
 printf("== 树的详细信息: \n");
 print_bstree(root, root->key, 0);
 printf("\n== 删除根节点: %d", arr[3]);
    root = delete_bstree(root, arr[3]);
 printf("\n== 中序遍历: ");
 inorder_bstree(root);
 printf("\n");
  // 销毁二叉树
 destroy_bstree(root);
}
```



编辑于 2019-09-25 16:50

算法与数据结构

C（编程语言）

C 语言入门