
/*
The graph is weakly connected, ie, it is possible to reach every node from every node ignoring edge direction.
http://mathworld.wolfram.com/WeaklyConnectedDigraph.html
*/
pred weaklyConnected {
 all x : Node | Node in x.adj + (~adj).x + x 
}

Other than this, the code seems correct.