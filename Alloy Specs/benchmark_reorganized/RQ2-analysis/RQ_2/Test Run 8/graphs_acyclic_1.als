sig Node {
    adj: set Node
}

pred undirected {
    adj = ~adj
}

pred oriented {
    no adj & ~adj
}

pred acyclic {
    no iden & adj.^adj
}

pred complete {
    all n: Node | n.adj = Node -- n
}

pred noLoops {
    no iden & adj
}

pred weaklyConnected {
    all n1, n2: Node | n1 in n2.*(adj + ~adj)
}

pred stonglyConnected {
    all n1, n2: Node | n1 in n2.*adj + n2.*~adj
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
    no adj & ~adj
}

assert orientedRepaired {
    oriented[] iff orientedOK[]
}

pred acyclicOK {
    no iden & adj.^adj
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
    no iden & adj
}

assert noLoopsRepaired {
    noLoops[] iff noLoopsOK[]
}

pred weaklyConnectedOK {
    all n1, n2: Node | n1 in n2.*(adj + ~adj)
}

assert weaklyConnectedRepaired {
    weaklyConnected[] iff weaklyConnectedOK[]
}

pred stonglyConnectedOK {
    all n1, n2: Node | n1 in n2.*adj + n2.*~adj
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