/*This file was automatically generated by AUnit v1.0's coverage----based test generation feature.
Test Suite Details:
----------------------------------------
Tests generated over: GRAPHS_templateAllCorrect.als
Number Valuations: 8
Number Tests: 38
Scope used: 5*/
/* 
Each node has a set of outgoing edges, representing a directed graph without multiple edges.
*/
sig Node {
	adj : set Node
}
/*
The graph is undirected, i.e., edges are symmetric.
*/
pred undirected {
	adj = ~adj
}
/*
The graph is oriented, i.e., contains no symmetric edges.
*/
pred oriented {
	no adj & ~adj
}
/*
The graph is acyclic, i.e., contains no directed cycles.
*/
pred acyclic {
	all a:Node | a not in a.^adj
}
/*
The graph is complete, i.e., every node is connected to every other node.
*/
pred complete {
	all n:Node | Node in n.adj
}
/*
The graph contains no loops, i.e., nodes have no transitions to themselves.
*/
pred noLoops {
	no (iden & adj)
}
/*
The graph is weakly connected, i.e., it is possible to reach every node from every node ignoring edge directions.
*/
pred weaklyConnected {
	all n:Node | Node in n.*(adj+~adj)
}
/*
The graph is strongly connected, i.e., it is possible to reach every node from every node considering edge directions.
*/
pred stronglyConnected {
	all n:Node | Node in n.*adj
}
/*
The graph is transitive, i.e., if two nodes are connected through a third node, they are also connected directly.
*/
pred transitive {
	adj.adj in adj
}
/*Perfect Oracle*/
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
	all n:Node | all m:Node ---- n | n in m.*(adj + ~adj)
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
pred stronglyConnectedOK {
	all n:Node | Node in n.*adj
}
assert stronglyConnectedRepaired {
	stronglyConnected[]  iff stronglyConnectedOK[]
}
pred transitiveOK {
	adj.adj in adj
}
assert transitiveRepaired {
	transitive[] iff transitiveOK[]
}

-------- PerfectOracleCommands
check undirectedRepaired expect 0
check orientedRepaired expect 0
check acyclicRepaired expect 0
check completeRepaired expect 0
check noLoopsRepaired expect 0
check weaklyConnectedRepaired expect 0
check stronglyConnectedRepaired expect 0
check transitiveRepaired expect 0

run {} for 5
run {} for 6

pred repair_pred_1 {
	acyclic[] iff acyclicOK[]
}
run repair_pred_1
assert repair_assert_1 {
	acyclic[] iff acyclicOK[]
}

check repair_assert_1