
/* Each teacher is responsible for some groups. */
pred inv12 {
  all t : Teacher | some (t.Teaches.Class).Groups 
}