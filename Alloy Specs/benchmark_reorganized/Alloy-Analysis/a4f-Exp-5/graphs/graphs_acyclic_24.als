/*
The graph is acyclic, ie, contains no directed cycles.
http://mathworld.wolfram.com/AcyclicDigraph.html
*/
pred acyclic {
  no n:Node | n in n.^adj //fixed
}
assert acyclicRepaired {
   acyclic[]  iff acyclicOK[]
}
check acyclicRepaired expect 1 //fixed all assertions will pass now