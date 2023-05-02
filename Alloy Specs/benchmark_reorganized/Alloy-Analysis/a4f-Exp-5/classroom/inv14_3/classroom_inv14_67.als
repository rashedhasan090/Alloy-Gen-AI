pred inv14_OK {
      all s : Student, c : Class | s in (Teaches.c).Tutors.Groups 
}
assert inv14_Repaired {
    inv14[] iff inv14_OK[]
}