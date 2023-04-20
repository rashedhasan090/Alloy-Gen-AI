/* 
The bug is in the inv14 predicate. The commented line is incorrect and should be replaced with the corrected line.
*/

pred inv14 {
    all s : Person, c : Class, t : Person, g : Group | (c -> s -> g in Groups) and t -> c in Teaches implies t -> g in Tutors
}