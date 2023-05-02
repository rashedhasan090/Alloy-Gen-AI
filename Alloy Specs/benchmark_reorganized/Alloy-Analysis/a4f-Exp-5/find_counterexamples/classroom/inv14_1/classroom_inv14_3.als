pred inv14_OK {
  all c : Class | all s : Student | (some c.Groups) implies s in ((Teacher & (Teaches . c)) . Tutors) 
}