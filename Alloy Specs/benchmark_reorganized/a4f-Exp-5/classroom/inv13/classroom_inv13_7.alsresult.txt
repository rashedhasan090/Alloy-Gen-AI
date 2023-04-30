/* Only teachers tutor, and only students are tutored. */
pred inv13_OK {
  all s:Student, t:Teacher | (s in Tutors and t in Teaches) implies s in t.Tutors
}
/* The tutoring chain of every person eventually reaches a Teacher. */
pred inv15_OK {
  all s : Person | some Teacher & ^Tutors.s 
}