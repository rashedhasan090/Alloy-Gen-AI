Fix:

pred weaklyConnected {
  all x, y : Node | ^adj.x & ^adj.y implies  ^adj.x in ^adj.y or ^adj.y in ^adj.x 
}