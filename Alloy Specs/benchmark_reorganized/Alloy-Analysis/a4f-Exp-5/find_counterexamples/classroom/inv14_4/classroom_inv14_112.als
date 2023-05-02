Fixed code for pred inv14:

pred inv14_OK {
  all s : Person, c : Class | some t<:(Teaches.c) | s -> (c.Groups).t in Tutors
}