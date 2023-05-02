
pred stonglyConnectedOK {
	all n:Node | Node in n.(^adj + ^~adj)
}