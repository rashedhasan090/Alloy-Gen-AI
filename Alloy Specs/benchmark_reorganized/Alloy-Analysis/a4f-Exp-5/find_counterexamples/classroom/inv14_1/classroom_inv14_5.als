fixed inv14 predicate:

pred inv14_OK {
  all c : Class, g : Group | g in c.Groups.Person.Tutors and all s : Student | s -> g in c.Groups implies some t : Teacher & t in c.Teaches and s in t.Tutors
}