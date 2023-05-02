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
    all a: Node | a not in a.^adj
}
pred complete {
    all n: Node | n.adj = (Node -- n)
}
pred noLoops {
    no iden & adj
}
pred weaklyConnected {
    all x, y: Node | x in y.*adj or y in x.*adj
}
pred stonglyConnected {
    all n: Node | n in n.*adj
}
pred transitive {
    adj.adj in adj
}
pred weaklyConnectedOK {
    all n: Node | Node in n.*(adj + ~adj)
}
assert weaklyConnectedRepaired {
    weaklyConnected[] iff weaklyConnectedOK[]
}
check weaklyConnectedRepaired expect 0