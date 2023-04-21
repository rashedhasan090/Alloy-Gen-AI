Test Suite Details:
Tests generated over: GRAPHS_templateAllCorrect.als
Number Valuations: 8
Number Tests: 38

Each node as a set of outgoing edges, representing a directed graph without multiple edged.

sig Node {
	adj : set Node
}

The graph is undirected, ie, edges are symmetric.
http://mathworld.wolfram.com/UndirectedGraph.html
pred undirected {
 	adj = ~adj  

 
 
 
 
 
}

The graph is oriented, ie, contains no symmetric edges.
http://mathworld.wolfram.com/OrientedGraph.html
pred oriented {
   no adj & ~adj 



 
 
 
 
 
 
 
}

The graph is acyclic, ie, contains no directed cycles.
http://mathworld.wolfram.com/AcyclicDigraph.html
pred acyclic {
 
 all a:Node | a not in a.^adj 

 
 
 
 
 
 
 
 
 
 
}

The graph is complete, ie, every node is connected to every other node.
http://mathworld.wolfram.com/CompleteDigraph.html
pred complete {
 
  all n:Node | Node in n.adj 


 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
}

The graph contains no loops, ie, nodes have no transitions to themselves.
http://mathworld.wolfram.com/GraphLoop.html
pred noLoops {
 no (iden & adj) 


 
 
 
 
 
 
 
 
 
 
}

The graph is weakly connected, ie, it is possible to reach every node from every node ignoring edge direction.
http://mathworld.wolfram.com/WeaklyConnectedDigraph.html
pred weaklyConnected {
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 all n : Node | Node in n.*adj & n 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
}

The graph is strongly connected, ie, it is possible to reach every node from every node considering edge direction.
http://mathworld.wolfram.com/StronglyConnectedDigraph.html
pred stonglyConnected {
 	all n:Node | Node in n.*adj  
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
}

The graph is transitive, ie, if two nodes are connected through a third node, they also are connected directly.
http://mathworld.wolfram.com/TransitiveDigraph.html
pred transitive {
 	adj.adj in adj 
 
}






pred undirectedOK {
	adj = ~adj
}
assert undirectedRepaired {
    undirected[] iff undirectedOK[]
}
pred orientedOK {
	no adj & ~adj 
}
assert orientedRepaired {
    oriented[] iff orientedOK[]
}
pred acyclicOK {
	all a:Node | a not in a.^adj
}
assert acyclicRepaired {
   acyclic[]  iff acyclicOK[]
}
pred completeOK {
	all n:Node | Node in n.adj
}
assert completeRepaired {
    complete[] iff completeOK[]
}
pred noLoopsOK {
	no (iden & adj)
}
assert noLoopsRepaired {
   noLoops[]  iff noLoopsOK[]
}
pred weaklyConnectedOK {
	all n:Node | Node in n.*(adj+~adj)
}
assert weaklyConnectedRepaired {
   weaklyConnected[]  iff weaklyConnectedOK[]
}
pred stonglyConnectedOK {
	all n:Node | Node in n.*adj
}
assert stonglyConnectedRepaired {
   stonglyConnected[]  iff stonglyConnectedOK[]
}
pred transitiveOK {
	adj.adj in adj
}
assert transitiveRepaired {
    transitive[] iff transitiveOK[]
}

 check undirectedRepaired expect 0
 check orientedRepaired expect 0
 check acyclicRepaired expect 0
 check completeRepaired expect 0
 check noLoopsRepaired expect 0
 check weaklyConnectedRepaired expect 0
 check stonglyConnectedRepaired expect 0
 check transitiveRepaired expect 0
pred repair_pred_1{weaklyConnected[] iff weaklyConnectedOK[] }
run repair_pred_1
assert repair_assert_1{weaklyConnected[] iff weaklyConnectedOK[] }
check repair_assert_1
