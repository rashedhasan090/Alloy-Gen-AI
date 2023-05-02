/*
The graph is strongly connected, ie, it is possible to reach every node from every node considering edge direction.
http://mathworld.wolfram.com/StronglyConnectedDigraph.html
*/
pred stonglyConnected {
 all n:Node | Node--n in (n.^adj + n.^~adj) 
}

// Fixed version below

pred stronglyConnected {
 all n: Node | n in n.~(adj + ~adj).~
}

// Updated assert for the repaired predicate

assert stonglyConnectedRepaired {
   stronglyConnected[] iff stonglyConnectedOK[]
}