
Fixed weaklyConnected predicate:

pred weaklyConnected {
  all n, x :Node | some n2:Node | n in (n2.^(adj + ~adj)) + ~(~adj).x 
}