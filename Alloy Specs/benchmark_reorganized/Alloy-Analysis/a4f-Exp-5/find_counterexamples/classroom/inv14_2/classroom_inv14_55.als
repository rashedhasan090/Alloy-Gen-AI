pred inv14_OK {
  all c:Class, s:Student, g:Group | g = (c->s)->Groups implies some t:Teacher | t -> c in Teaches and t -> s in Tutors
} 

assert inv14_Repaired {
  inv14[] iff inv14_OK[]
}