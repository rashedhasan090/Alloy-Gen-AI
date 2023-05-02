
The fixed code for inv9 is:

/* No class has more than one teacher assigned.*/
pred inv9 {
	all c:Class | lone t:Teacher | t.Teaches = c and t not in Student
}

Note: This predicate checks that each class has at most one teacher assigned to it, and that the assigned teacher is not a student.