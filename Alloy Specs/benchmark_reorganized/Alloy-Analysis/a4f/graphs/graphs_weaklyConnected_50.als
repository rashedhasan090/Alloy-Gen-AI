
pred weaklyConnected {
  all n:Node | Node in n.(^adj + ^~adj) 
}