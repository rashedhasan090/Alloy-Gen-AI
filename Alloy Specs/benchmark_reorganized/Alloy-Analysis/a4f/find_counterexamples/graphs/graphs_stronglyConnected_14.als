There is a bug in the stonglyConnected pred. The correct version would be:

pred stonglyConnected {
	all n:Node | Node in n.*adj && n.*adj in Node
}