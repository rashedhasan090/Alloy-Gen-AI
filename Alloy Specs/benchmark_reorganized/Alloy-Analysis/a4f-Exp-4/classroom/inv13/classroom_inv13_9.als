
pred inv13_OK {
  all s:Person, t:Teacher | s not in t.Tutors and t not in s.Tutors
}