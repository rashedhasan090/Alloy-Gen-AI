//Bug fixed in weaklyConnected predicate
pred weaklyConnected {
  all n:Node | n in n.(^adj + ^~adj) 
}