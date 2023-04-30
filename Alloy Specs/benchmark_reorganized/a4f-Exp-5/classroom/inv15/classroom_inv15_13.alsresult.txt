The fixed code is:

pred inv15_OK {
  all s : Person | some t : Teacher | some ^Tutors.s & t in ^Tutors.s 
}

The bug was in the implication inside the quantifier, it was not including all possible combinations of persons involved in the tutoring chain.