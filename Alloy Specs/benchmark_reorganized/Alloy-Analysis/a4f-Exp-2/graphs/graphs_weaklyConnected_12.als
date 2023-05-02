The bug is in the "weaklyConnected" predicate. There are two "Bug" comments in the predicate. The fixed predicate is:

pred weaklyConnected {
 	all a:Node, b:Node | b in a.^(adj + ~adj)
}