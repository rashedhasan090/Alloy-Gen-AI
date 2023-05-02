pred inv13_OK {
  all t:Teacher,s:Student,c:Class | t in Teaches.c and s in c.Groups.Person => s in t.Tutors
}