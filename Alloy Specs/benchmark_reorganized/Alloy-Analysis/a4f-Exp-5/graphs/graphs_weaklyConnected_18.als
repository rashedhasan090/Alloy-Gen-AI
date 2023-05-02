/*
The graph is weakly connected, ie, it is possible to reach every node from every node ignoring edge direction.
http://mathworld.wolfram.com/WeaklyConnectedDigraph.html
*/
pred weaklyConnected {
 all n : Node | n in (n.^adj + n.^~adj) 
}
/*
The graph is strongly connected, ie, it is possible to reach every node from every node considering edge direction.
http://mathworld.wolfram.com/StronglyConnectedDigraph.html
*/
pred stonglyConnected {
 	all n:Node | Node in n.*adj  
}
/*
The graph is transitive, ie, if two nodes are connected through a third node, they also are connected directly.
http://mathworld.wolfram.com/TransitiveDigraph.html
*/
pred transitive {
 	adj.adj in adj 
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
	all n:Node | Node in n.adj
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
	all n:Node | n in (n.*adj+ n.*~adj)
}
assert weaklyConnectedRepaired {
   weaklyConnected[]  iff weaklyConnectedOK[]
}
----------------
pred stonglyConnectedOK {
	all n:Node | Node in n.*adj
}
assert stonglyConnectedRepaired {
   stonglyConnected[]  iff stonglyConnectedOK[]
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
 check stonglyConnectedRepaired expect 0
 check transitiveRepaired expect 0
pred repair_pred_1{weaklyConnected[] iff weaklyConnectedOK[] }
run repair_pred_1
assert repair_assert_1{weaklyConnected[] iff weaklyConnectedOK[] }
check repair_assert_1