pred weaklyConnectedOK {
//Fixed: changed Node to n.adj 
	all n:Node | n in n.*(adj+~adj)
}