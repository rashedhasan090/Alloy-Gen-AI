pred transitiveOK {
    all a,b,c:Node | (a->b in adj and b->c in adj) implies a->c in adj
}
assert transitiveRepaired {
    transitive[] iff transitiveOK[]
}