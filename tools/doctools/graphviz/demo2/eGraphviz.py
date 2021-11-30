from graphviz import Digraph
g = Digraph('test')
g.node(name='a')
g.node(name='b')
g.node(name='c')
g.edge('a','b',color='green')
# g.edges(['bc'],constraint='false')
g.view()
# g.draw('test_pygraphviz.png', format='png', prog='neato')
# run by [" dot"  ,'-Tpdf', '-O', '测试图片.gv' ]