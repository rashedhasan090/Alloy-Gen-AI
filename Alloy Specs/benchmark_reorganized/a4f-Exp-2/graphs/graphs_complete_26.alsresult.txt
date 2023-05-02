/*
Each node has a set of outgoing edges,
representing a directed graph without multiple edges.
*/

sig Node {
  adj: set Node
}

/*
The graph is undirected, meaning edges are symmetric.
*/

pred undirected {
  adj = ~adj
}

/*
The graph is oriented, meaning it contains no symmetric edges.
*/

pred oriented {
  all n: Node | no n.adj & n in n.^adj
}

/*
The graph is acyclic, meaning it contains no directed cycles.
*/

pred acyclic {
  all n: Node | n not in n.^adj
}

/*
The graph is complete, meaning every node is connected to every other node.
*/

pred complete {
  all n: Node |
    n != Node implies n in n.^adj
}

/*
The graph contains no loops, meaning nodes have no transitions to themselves.
*/

pred noLoops {
  no iden & adj
}

/*
The graph is weakly connected, meaning it is possible to reach every node from every node ignoring edge direction.
*/

pred weaklyConnected {
  all n, m: Node | n in m.*(adj + ~adj)
}

/*
The graph is strongly connected, meaning it is possible to reach every node from every node considering edge direction.
*/

pred stronglyConnected {
  all n: Node | n in n.*adj
}

/*
The graph is transitive, meaning that if two nodes are connected through a third node, they are also connected directly.
*/

pred transitive {
  adj.adj in adj
}

/*
The assertions below ensure that the original predicates are
equivalent to the repaired versions with the bug(s) fixed.
*/

pred undirectedOK {
  adj = ~adj
}

assert undirectedRepaired {
  undirected[] <=> undirectedOK[]
}

pred orientedOK {
  all n, m: Node | (n in m.adj) implies (m !in n.adj)
}

assert orientedRepaired {
  oriented[] <=> orientedOK[]
}

pred acyclicOK {
  all n: Node | n !in n.^adj
}

assert acyclicRepaired {
  acyclic[] <=> acyclicOK[]
}

pred completeOK {
  all n, m: Node | n != m implies (n in m.adj or m in n.adj)
}

assert completeRepaired {
  complete[] <=> completeOK[]
}

pred noLoopsOK {
  no iden & adj
}

assert noLoopsRepaired {
  noLoops[] <=> noLoopsOK[]
}

pred weaklyConnectedOK {
  all n, m: Node | n in m.*(adj + ~adj)
}

assert weaklyConnectedRepaired {
  weaklyConnected[] <=> weaklyConnectedOK[]
}

pred stronglyConnectedOK {
  all n: Node | n in n.*adj
}

assert stronglyConnectedRepaired {
  stronglyConnected[] <=> stronglyConnectedOK[]
}

pred transitiveOK {
  adj.adj in adj
}

assert transitiveRepaired {
  transitive[] <=> transitiveOK[]
}

check undirectedRepaired expect 0
check orientedRepaired expect 0
check acyclicRepaired expect 0
check completeRepaired expect 0
check noLoopsRepaired expect 0
check weaklyConnectedRepaired expect 0
check stronglyConnectedRepaired expect 0
check transitiveRepaired expect 0

pred repair_pred_1 {
  complete[] <=> completeOK[]
}

run repair_pred_1

assert repair_assert_1 {
  complete[] <=> completeOK[]
}

check repair_assert_1