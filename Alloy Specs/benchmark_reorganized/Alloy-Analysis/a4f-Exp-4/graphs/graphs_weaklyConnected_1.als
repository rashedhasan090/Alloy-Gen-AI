
pred weaklyConnectedOK {
	all n:Node | Node in n.*((adj+~adj))
}

The rest of the code is correct.