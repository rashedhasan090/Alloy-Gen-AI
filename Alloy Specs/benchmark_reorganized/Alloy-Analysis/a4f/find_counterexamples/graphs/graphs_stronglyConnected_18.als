
pred stonglyConnected {
	all n:Node | Node in n.(*adj + *~adj) 
}