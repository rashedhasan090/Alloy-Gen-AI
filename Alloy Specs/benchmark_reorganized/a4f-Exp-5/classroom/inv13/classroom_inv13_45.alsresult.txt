pred inv13_OK {
  Teacher.Tutors in Student and Student.Tutors in Teacher  
}
assert inv13_Repaired {
    inv13[] iff inv13_OK[]
}