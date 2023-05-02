
/* Every student in a class is at least tutored by one of the teachers
 * assigned to that class. */
pred inv14 {
  all c : Class, s : Student | 
  some t : Teacher | t -> c in Teaches and s -> (c -> t) in Groups
}

Note that the original predicate attempted to express that every student in a class is tutored by every teacher assigned to that class, which is too restrictive. The correct version of the predicate states that every student in a class is tutored by at least one teacher assigned to that class.