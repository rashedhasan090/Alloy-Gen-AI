Fixed code:

pred inv13_OK {
  no Student.Tutors and Teacher in Tutors
}

assert inv13_Repaired {
    inv13[] iff inv13_OK[]
}