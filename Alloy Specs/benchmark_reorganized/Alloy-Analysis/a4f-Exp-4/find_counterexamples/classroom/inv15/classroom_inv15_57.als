
/* The tutoring chain of every person eventually reaches a Teacher or a Student who tutors another student. */
pred inv15_OK {
  all s : Person | some Teacher & ^Tutors.s or some p: Student | p in s.Tutors and some q: Student | q in p.Tutors
}