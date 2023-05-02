There is a missing parenthesis in the weaklyConnected predicate. The corrected code is:

pred weaklyConnected {
   all n:Node | some n.(n->(n.*adj + ~n.*adj)) 
}