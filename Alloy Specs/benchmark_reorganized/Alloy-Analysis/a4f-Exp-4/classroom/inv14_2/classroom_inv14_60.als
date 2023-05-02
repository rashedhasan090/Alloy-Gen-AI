
pred inv14_OK {
  all s : Student, c : Class, t : Teacher, g : Group | (c -> g in Groups) and t -> c in Teaches implies s -> g in t.Tutors 
}