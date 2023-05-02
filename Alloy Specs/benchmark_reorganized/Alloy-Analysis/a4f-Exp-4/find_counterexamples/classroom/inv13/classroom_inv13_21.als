
/* Only teachers tutor, and only students are tutored. */
pred inv13 {
	all t:Teacher,s:Student,c:Class | t->c in Teaches implies c->(s.Tutors) and t->s in Tutors 
}