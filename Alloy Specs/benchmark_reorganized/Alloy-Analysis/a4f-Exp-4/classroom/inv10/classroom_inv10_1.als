
/* For every class, every student has a group assigned. */
pred inv10 {
	all c:Class | (c.Groups.Student) = Student 
}