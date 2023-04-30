pred inv15_OK {
  all s : Person | some t : Teacher & ^Tutors.s
}
assert inv15_Repaired {
    inv15[] iff inv15_OK[]
}