There is a missing parenthesis in the inv12 predicate. The fixed code is:

pred inv12 {
 all t : Teacher | some ((t.Teaches).Groups) 
}