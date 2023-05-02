sig Node {
   adj: set Node
}

pred undirected {
   adj = ~adj
}

pred oriented {
   no adj & adj = ~adj
}

pred acyclic {
   no iden & acyclic_helper[]
}

pred acyclic_helper {
   all n: Node | no n.^adj & n in n.^adj
}

pred complete {
   all n: Node | n.adj = Node -- n
}

pred noLoops {
   no iden & adj
}

pred weaklyConnected {
   all n1, n2: Node | n1 in n2.*(adj+~adj)
}

pred stronglyConnected {
   all n: Node | n in n.(*adj + *~adj)
}

pred transitive {
   adj.adj in adj
}

// corrected assertion names
assert undirected_assertion {
   undirected[] iff undirectedOK[]
}

assert oriented_assertion {
   oriented[] iff orientedOK[]
}

assert acyclic_assertion {
   acyclic[] iff acyclicOK[]
}

assert complete_assertion {
   complete[] iff completeOK[]
}

assert noLoops_assertion {
   noLoops[] iff noLoopsOK[]
}

assert weaklyConnected_assertion {
   weaklyConnected[] iff weaklyConnectedOK[]
}

assert stronglyConnected_assertion {
   stronglyConnected[] iff stronglyConnectedOK[]
}

assert transitive_assertion {
   transitive[] iff transitiveOK[]
}

// run all assertions
check undirected_assertion expect 0
check oriented_assertion expect 0
check acyclic_assertion expect 0
check complete_assertion expect 0
check noLoops_assertion expect 0
check weaklyConnected_assertion expect 0
check stronglyConnected_assertion expect 0
check transitive_assertion expect 0