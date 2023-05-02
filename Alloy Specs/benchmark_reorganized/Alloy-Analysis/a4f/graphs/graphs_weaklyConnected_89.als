Fix:

pred weaklyConnected {
    all x : Node | x in x.*(adj+~adj)
}