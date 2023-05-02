The bug was in the inv14 predicate. The repaired version of inv14 is provided below.

Fixed code:
/* Every student in a class is at least tutored by all the teachers
 * assigned to that class. */
pred inv14_OK {
      all s : Student, c : Class | some t : Teacher | t -> c in Teaches and s -> c -> t in Groups implies s in t.^Tutors 
}
assert inv14_Repaired {
    inv14[] iff inv14_OK[]
}