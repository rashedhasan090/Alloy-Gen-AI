sig Node {
    adj: set Node
}

pred undirected {
    adj = ~adj
}

pred oriented {
    all n:Node | n not in n.^adj
}

pred acyclic {
    all n:Node | n not in n.^adj
}

pred complete {
    all n:Node | n.adj = Node -- n
}

pred noLoops {
    no iden & adj
}

pred weaklyConnected {
    all n, m: Node | n in m.*(adj + ~adj)
}

pred stronglyConnected {
    all n: Node | n in n.*adj and n in adj.*n
}

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
    no adj & ~ adj
}

assert orientedRepaired {
    oriented[] iff orientedOK[]
}

pred acyclicOK {
    all n:Node | n not in n.^adj
}

assert acyclicRepaired {
    acyclic[] iff acyclicOK[]
}

pred completeOK {
    all n:Node | n.adj = Node -- n
}

assert completeRepaired {
    complete[] iff completeOK[]
}

pred noLoopsOK {
    no iden & adj
}

assert noLoopsRepaired {
    noLoops[] iff noLoopsOK[]
}

pred weaklyConnectedOK {
    all n, m: Node | n in m.*(adj + ~adj)
}

assert weaklyConnectedRepaired {
    weaklyConnected[] iff weaklyConnectedOK[]
}

pred stronglyConnectedOK {
    all n: Node | n in n.*adj and n in adj.*n
}

assert stronglyConnectedRepaired {
    stronglyConnected[] iff stronglyConnectedOK[]
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
check stronglyConnectedRepaired expect 0
check transitiveRepaired expect 0

pred repair_pred_1 {
    oriented[] iff orientedOK[]
}

run repair_pred_1

assert repair_assert_1 {
    oriented[] iff orientedOK[]
}

check repair_assert_1