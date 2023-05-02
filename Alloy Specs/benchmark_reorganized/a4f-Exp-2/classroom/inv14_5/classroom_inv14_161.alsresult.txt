pred inv14_OK {
  all s : Person, c : Class, g : Group | (c -> s -> g in Groups) imply some t : Teacher | t -> c in Teaches and g in t.Teaches.Groups and s in t.Tutors
}