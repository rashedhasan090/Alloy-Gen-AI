pred inv14_OK {
  all s : Student, c : Class | some (c.Groups) and c.Teaches & Teacher implies some s.(c.Groups & (Teacher.Tutors))
}
assert inv14_Repaired {
    inv14[] iff inv14_OK[]
}