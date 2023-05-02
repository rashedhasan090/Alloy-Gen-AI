//Bug fixed
pred weaklyConnectedOK {
  all x : Node | x in x.*adj + ~(*adj).x 
}
```