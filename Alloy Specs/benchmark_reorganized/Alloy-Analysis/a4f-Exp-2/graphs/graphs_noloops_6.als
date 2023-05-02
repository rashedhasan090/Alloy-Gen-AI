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
	all n:Node | (n != this) implies (this in n.adj)
}

pred noLoops {
	all a:Node | a not in a.adj
}

pred weaklyConnected {
	all n:Node | Node in n.*(adj+~adj)
}

pred stonglyConnected {
	all n:Node | Node in n.*adj
}

pred transitive {
	adj.adj in adj
}

pred noLoopsOK {
	no (iden & adj)
}

assert noLoopsRepaired {
   noLoops[]  iff noLoopsOK[]
}