pred inv14_OK {
      all s : Student, c : Class | some (c.Groups) and some Teacher<:Teaches implies s in (Teacher<:Tutors).c 
}