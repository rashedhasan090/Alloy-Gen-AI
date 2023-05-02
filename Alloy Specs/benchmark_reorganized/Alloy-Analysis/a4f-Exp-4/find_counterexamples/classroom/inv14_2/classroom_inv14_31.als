
pred inv14_OK {
  all s : Student, c : Class | some g : Group | c -> s -> g in Groups implies all t : Teacher | t -> c in Teaches implies g in t.Tutors
}

Here the aim is to say that every student in a class is tutored by all the teachers of that class, not just some of them.