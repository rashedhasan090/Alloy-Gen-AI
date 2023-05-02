
/* For every class, every student has a group assigned. */
pred inv10 {
  all c : Class | all s : Student | one s.(c.Groups) 
}