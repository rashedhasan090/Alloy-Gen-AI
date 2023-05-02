
/* The tutoring chain of every student eventually reaches a Teacher. */
pred inv15_OK {
  all s : Student | some Teacher & ^Tutors.s 
}