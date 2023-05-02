pred inv12_OK {
  all t : Teacher, c : Class | some (c.Groups).(t) implies t -> c in Teaches  
}