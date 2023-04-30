The fixed code is:

pred inv15_OK {
  all s : Person | some Teacher & ^s.Tutors 
}

Note that in the implication it should be ^s.Tutors instead of ^Tutors.s.