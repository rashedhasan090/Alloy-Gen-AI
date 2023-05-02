
pred stonglyConnectedOK {
	all n1,n2:Node | (n2 in n1.^adj) implies (n1 in n2.^adj)
}