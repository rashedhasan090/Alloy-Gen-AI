pred inv15_OK {
  all p : Person | some Teacher & ^Tutors.p 
}
assert inv15_Repaired {
    inv15[] iff inv15_OK[]
}