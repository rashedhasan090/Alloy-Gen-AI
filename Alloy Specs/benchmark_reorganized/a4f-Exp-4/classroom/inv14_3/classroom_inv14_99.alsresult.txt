The bug was in inv14. The correct predicate is:

pred inv14_OK {
  all s : Student, c : Class | c.Groups.s in Tutors & Teacher & Teaches.c 
}