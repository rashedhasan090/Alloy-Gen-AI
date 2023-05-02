pred inv13_OK {
  all t : Teacher, s : Student | t.Tutors in Teacher and s.Tutors in Student 
}