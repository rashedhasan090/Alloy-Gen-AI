
pred weaklyConnectedOK {
    all x, y : Node | Node in x.*(adj+~adj).y
}