sig Node {
	adj : set Node
}

pred undirected {
    adj = ~adj
}

pred oriented {
    no adj & ~adj 
}

pred acyclic {
    all a:Node | a not in a.^adj 
}

pred complete {
    all n:Node | n.adj = Node ---- n
}

pred noLoops {
    no (iden & adj)
}

pred weaklyConnected {
    all n:Node | Node in n.*(~adj+adj)
}

pred stonglyConnected {
    all n:Node | Node in n.*adj
}

pred transitive {
    adj.adj in adj
}

pred completeOK {
    all n:Node | n.adj = Node ---- n
}

assert undirectedRepaired {
    undirected[] iff adj = ~adj
}

assert orientedRepaired {
    oriented[] iff no adj & ~adj
}

assert acyclicRepaired {
    acyclic[] iff all a:Node | a not in a.^adj
}

assert completeRepaired {
    complete[] iff all n:Node | n.adj = Node ---- n
}

assert noLoopsRepaired {
    noLoops[] iff no (iden & adj) 
}

assert weaklyConnectedRepaired {
    weaklyConnected[] iff all n:Node | Node in n.*(~adj+adj)
}

assert stonglyConnectedRepaired {
    stonglyConnected[] iff all n:Node | Node in n.*adj 
}

assert transitiveRepaired {
    transitive[] iff adj.adj in adj 
}

check undirectedRepaired expect 0
check orientedRepaired expect 0
check acyclicRepaired expect 0
check completeRepaired expect 0
check noLoopsRepaired expect 0
check weaklyConnectedRepaired expect 0
check stonglyConnectedRepaired expect 0
check transitiveRepaired expect 0