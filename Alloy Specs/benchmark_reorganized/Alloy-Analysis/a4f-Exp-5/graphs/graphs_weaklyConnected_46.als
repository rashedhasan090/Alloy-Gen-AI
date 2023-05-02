/*
The graph is weakly connected, ie, it is possible to reach every node from every node ignoring edge direction.
http://mathworld.wolfram.com/WeaklyConnectedDigraph.html
*/
pred weaklyConnected {
  all n:Node | Node in (n.*(adj+~adj)) //fixed bug here
}
/*
The graph is strongly connected, ie, it is possible to reach every node from every node considering edge direction.
http://mathworld.wolfram.com/StronglyConnectedDigraph.html
*/
pred stonglyConnected {
  all n:Node | Node in n.*adj  
}
/*
The graph is weakly connected, ie, it is possible to reach every node from every node ignoring edge direction.
http://mathworld.wolfram.com/WeaklyConnectedDigraph.html
*/
pred weaklyConnectedOK {
  all n:Node | Node in n.*(adj+~adj) //fixed bug here
}
assert weaklyConnectedRepaired {
   weaklyConnected[]  iff weaklyConnectedOK[]
}