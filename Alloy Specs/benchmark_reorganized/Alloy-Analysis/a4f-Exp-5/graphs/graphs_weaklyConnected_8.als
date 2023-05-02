Fix for the bug in weaklyConnected predicate:

pred weaklyConnected {
   all a,b:Node | a in b.^adj or b in a.^adj
}