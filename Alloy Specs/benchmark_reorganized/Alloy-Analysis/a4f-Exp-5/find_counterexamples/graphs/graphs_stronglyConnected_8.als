sig Node {
    adj: set Node
}

pred undirected {
    adj = ~adj
}

pred oriented {
    no adj & adj~
}

pred acyclic {
    no iden & Node in Node.^adj
}

pred complete {
    all n: Node | all m: Node -- n | n in m.adj and m in n.adj
}

pred noLoops {
    no iden & adj
}

pred weaklyConnected {
    all n: Node | all m: Node -- n | Node in n.*(adj + ~adj).m
}

pred stonglyConnected {
    all n: Node | Node in n.*(adj + ~adj)
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
    no adj & adj~
}

assert orientedRepaired {
    oriented[] iff orientedOK[]
}

pred acyclicOK {
    no iden & Node in Node.^adj
}

assert acyclicRepaired {
    acyclic[] iff acyclicOK[]
}

pred completeOK {
    all n: Node | all m: Node -- n | n in m.adj and m in n.adj
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
    all n: Node | all m: Node -- n | Node in n.*(adj + ~adj).m
}

assert weaklyConnectedRepaired {
    weaklyConnected[] iff weaklyConnectedOK[]
}

pred stonglyConnectedOK {
    all n: Node | Node in n.*(adj + ~adj)
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
    stonglyConnected[] iff stonglyConnectedOK[]
}

run repair_pred_1

assert repair_assert_1 {
    stonglyConnected[] iff stonglyConnectedOK[]
}

check repair_assert_1