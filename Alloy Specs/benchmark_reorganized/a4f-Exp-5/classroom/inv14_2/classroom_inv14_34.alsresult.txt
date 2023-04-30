pred inv14_OK {
  all s : Person, c : Class, g : Group | (c.Groups.s = g) implies some t : Teacher | t.Teaches = c and t.Tutors = s
}