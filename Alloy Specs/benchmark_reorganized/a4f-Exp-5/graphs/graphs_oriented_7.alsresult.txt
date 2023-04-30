pred orientedOK {
	all n:Node | no (n.adj & ~n.adj)
}