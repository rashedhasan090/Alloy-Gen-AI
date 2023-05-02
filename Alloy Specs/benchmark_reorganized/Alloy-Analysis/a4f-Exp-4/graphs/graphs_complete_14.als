
/*
The graph is complete, ie, every node is connected to every other node.
http://mathworld.wolfram.com/CompleteDigraph.html
*/
pred complete {
  all n : Node | all m : Node | ((n != m) => m in n.adj)
}