
/* The tutoring chain of every person eventually reaches a Teacher. */
pred inv15_OK {
  all s : Person | some Teacher & ^Tutors.s 
}