
pred inv15 {
	all p:Person | some t:Teacher | t in p.^Tutors & t in Teaches.Class
}

This ensures that the tutoring chain of every person eventually reaches a Teacher who is assigned to a class.