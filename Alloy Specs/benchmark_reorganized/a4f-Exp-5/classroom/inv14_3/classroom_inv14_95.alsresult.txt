pred inv14_OK {
  all s : Person, c : Class | some c.(Teacher<:Teaches) implies s.(c.Groups) <: Teacher.Tutors 
}

assert inv14_Repaired {
    inv14[] iff inv14_OK[]
}

check inv14_Repaired expect 0