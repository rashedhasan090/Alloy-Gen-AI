pred inv13_OK {
  all s:Student,t:Teacher | (s not in Person.^~Tutors and t not in Person.^Tutors) implies (s not in t.Teaches) 
}