pred inv14_OK {
  all s : Student, c : Class | some (Teacher<:Teaches).c implies some (Teacher<:Tutors).s.(c.Groups) 
}