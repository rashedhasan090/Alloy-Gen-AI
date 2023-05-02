
/* Only teachers tutor, and only students are tutored. */
pred inv13 {
	all t:Teacher | t.Teaches.Tutors in Teacher and t.Tutors in Student
}