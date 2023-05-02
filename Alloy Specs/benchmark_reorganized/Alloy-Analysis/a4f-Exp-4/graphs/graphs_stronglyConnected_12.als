
The fixed code for "stonglyConnectedOK" predicate is as follows:

pred stonglyConnectedOK {
	all n:Node | Node in n.*(adj+~adj) // use closure of forwards and backwards adjacency relations
}

With this change, the Alloy specification should now be correct.