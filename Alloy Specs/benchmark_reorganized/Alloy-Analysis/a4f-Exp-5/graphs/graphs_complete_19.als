/*
The graph is complete, ie, every node is connected to every other node.
http://mathworld.wolfram.com/CompleteDigraph.html
*/
pred complete {
 all n : Node | n.adj = Node -- n
}

/*
The graph is weakly connected, ie, it is possible to reach every node from every node ignoring edge direction.
http://mathworld.wolfram.com/WeaklyConnectedDigraph.html
*/
pred weaklyConnected {
 all n:Node, m:Node | m in n.*(adj+~adj) 
}

/*
The graph is strongly connected, ie, it is possible to reach every node from every node considering edge direction.
http://mathworld.wolfram.com/StronglyConnectedDigraph.html
*/
pred stronglyConnected {
 all n:Node | n.*adj & adj.n != none and n.--n.*adj & adj.n != none
}

/*
The graph contains no loops, ie, nodes have no transitions to themselves.
http://mathworld.wolfram.com/GraphLoop.html
*/
pred noLoops {
 no iden & adj 
}

/*======== IFF PERFECT ORACLE ===============*/
pred undirectedOK {
 adj = ~adj
}
assert undirectedRepaired {
 undirected[] iff undirectedOK[]
}
----------------
pred orientedOK {
 no adj & ~adj 
}
assert orientedRepaired {
 oriented[] iff orientedOK[]
}
----------------
pred acyclicOK {
 all a:Node | a not in a.^adj
}
assert acyclicRepaired {
 acyclic[]  iff acyclicOK[]
}
----------------
pred completeOK {
 all n : Node | n.adj = Node -- n
}
assert completeRepaired {
 complete[] iff completeOK[]
}
----------------
pred noLoopsOK {
 no (iden & adj)
}
assert noLoopsRepaired {
 noLoops[]  iff noLoopsOK[]
}
----------------
pred weaklyConnectedOK {
 all n:Node, m:Node | m in n.*(adj+~adj) 
}
assert weaklyConnectedRepaired {
 weaklyConnected[]  iff weaklyConnectedOK[]
}
----------------
pred stronglyConnectedOK {
 all n:Node | n.*adj & adj.n != none and n.--n.*adj & adj.n != none
}
assert stronglyConnectedRepaired {
 stronglyConnected[]  iff stronglyConnectedOK[]
}
----------------
pred transitiveOK {
 adj.adj in adj
}
assert transitiveRepaired {
 transitive[] iff transitiveOK[]
}
--
---- PerfectOracleCommands
check undirectedRepaired expect 0
check orientedRepaired expect 0
check acyclicRepaired expect 0
check completeRepaired expect 0
check noLoopsRepaired expect 0
check weaklyConnectedRepaired expect 0
check stronglyConnectedRepaired expect 0
check transitiveRepaired expect 0
pred repair_pred_1{complete[] iff completeOK[] }
run repair_pred_1
assert repair_assert_1{complete[] iff completeOK[] }
check repair_assert_1