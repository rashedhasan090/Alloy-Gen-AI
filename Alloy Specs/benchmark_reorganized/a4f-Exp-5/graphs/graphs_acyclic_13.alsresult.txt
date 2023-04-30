pred acyclicOK {
    no iden & (adj + ~adj).^2
}
assert acyclicRepaired {
    acyclic[] iff acyclicOK[]
}