
pred weaklyConnected {
  all n1,n2:Node | n1 in n2.^(adj+~adj) 
}