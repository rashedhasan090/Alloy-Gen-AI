pred inv14_OK {
  all c:Class, s:Student | some t:Teacher | Some g:Group | (t -> c) in Teaches and (c -> s -> g) in Groups => (s -> g) in t.Tutors
}

/* Every student in a class is at least tutored by all the teachers
 * assigned to that class. */
pred inv14 {
  all c:Class,s:Student,t:Teacher | some s.(c.Groups) => ((s -> c.Groups) in t.Tutors)
} 

assert inv14_Repaired {
    inv14[] iff inv14_OK[]
}