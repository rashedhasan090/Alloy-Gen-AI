
/* The tutoring chain of every person eventually reaches a Teacher. */
pred inv15 {
  some t:Teacher | all p:Person | t in p.^Tutors 
}