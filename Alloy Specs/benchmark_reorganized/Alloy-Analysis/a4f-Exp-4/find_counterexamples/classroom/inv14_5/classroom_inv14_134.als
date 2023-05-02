
/* Every student in a class is tutored by all the teachers assigned to that class. */
pred inv14_OK {
  all s:Student,c:Class | some t:Teacher | s in t.Tutors and c.Groups.s = t 
} 

Note how we changed "Groups.s" to "c.Groups.s" in the predicate to specify that the group assigned to the student is the one assigned to the class.