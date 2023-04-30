pred weaklyConnectedOK {
	all n : Node | n in n.^adj or n.^adj in n 
}