pred inv13_OK {
  all s:Student, t:Teacher | s not in Person.^Tutors[t] and t not in Person.Tutors[s] 
}
