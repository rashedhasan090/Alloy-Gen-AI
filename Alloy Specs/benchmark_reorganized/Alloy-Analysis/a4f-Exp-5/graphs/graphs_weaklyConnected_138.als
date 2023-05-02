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
    no iden & acyclic[n:Node] {
        no n -> n & n -> n in n.^adj
    }
}

pred complete {
    all n: Node | n.adj = Node -- n
}

pred noLoops {
    no iden & no (n & iden & n -> n)
}

pred weaklyConnected {
    all n: Node | Node in n.*(adj + ~adj)
}

pred stonglyConnected {
    all n: Node | Node in n.^adj and Node in n.~adj
}

pred transitive {
    adj.adj in adj
}

/* IFF PERFECT ORACLE */

pred undirectedOK {
    adj = ~adj
}

assert undirectedRepaired {
    undirected[] iff undirectedOK[]
}

pred orientedOK {
    no adj & adj = ~adj
}

assert orientedRepaired {
    oriented[] iff orientedOK[]
}

pred acyclicOK {
    no iden & acyclic[n:Node] {
        no n -> n & n -> n in n.^adj
    }
}

assert acyclicRepaired {
    acyclic[] iff acyclicOK[]
}

pred completeOK {
    all n: Node | n.adj = Node -- n
}

assert completeRepaired {
    complete[] iff completeOK[]
}

pred noLoopsOK {
    no iden & no (n & iden & n -> n)
}

assert noLoopsRepaired {
    noLoops[] iff noLoopsOK[]
}

pred weaklyConnectedOK {
    all n: Node | Node in n.*(adj + ~adj)
}

assert weaklyConnectedRepaired {
    weaklyConnected[] iff weaklyConnectedOK[]
}

pred stonglyConnectedOK {
    all n: Node | Node in n.^adj and Node in n.~adj
}

assert stonglyConnectedRepaired {
    stonglyConnected[] iff stonglyConnectedOK[]
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

pred repair_pred_1 {
    weaklyConnected[] iff weaklyConnectedOK[]
}

run repair_pred_1

assert repair_assert_1 {
    weaklyConnected[] iff weaklyConnectedOK[]
}

check repair_assert_1