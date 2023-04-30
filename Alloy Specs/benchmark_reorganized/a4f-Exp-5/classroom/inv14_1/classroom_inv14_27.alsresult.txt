pred inv14_OK {
  all c:Class,s:Student,g:Group | (g in c.Groups.s) implies some t:Teacher | t->c in Teaches and t in s.^~Tutors
}

assert inv14_Repaired {
  inv14[] iff inv14_OK[]
}