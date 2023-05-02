
pred weaklyConnectedOK {
    all n:Node, m:Node | Node in n.^adj + ^~adj.m 
}