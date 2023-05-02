The bug was in the inv14 predicate. The fixed code for the predicate is:

/* Every student in a class is tutored by at least one teacher assigned to that class. */
pred inv14 {
   all s : Person, c : Class, g : Group |
   some t : Teacher |
   t -> c in Teaches and c -> g in Groups and s -> g in t.Tutors
}