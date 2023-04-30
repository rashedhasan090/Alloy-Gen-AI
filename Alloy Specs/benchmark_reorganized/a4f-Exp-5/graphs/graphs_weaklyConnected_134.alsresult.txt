Fixed code:

pred weaklyConnected {
  all x, y : Node | ((x->y in adj) implies (y->x not in adj)) and (Node in x.^adj + x)
}