
pred inv14_OK {
  all s : Student, c : Class | c.Groups.(s) in c.Teaches.Tutors 
}