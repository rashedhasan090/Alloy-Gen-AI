pred inv13_OK {
  Teacher in Person.Tutors and Student in Tutors.Person  
}
assert inv13_Repaired {
    inv13[] iff inv13_OK[]
}