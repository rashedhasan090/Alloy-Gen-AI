pred inv14_OK {
  all s : Student, c : Class, g : Group | (c -> s -> g in Groups) implies (all t : Teacher & Teaches.c | s in t.Tutors)
}