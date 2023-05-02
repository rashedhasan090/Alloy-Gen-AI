/* The registered persons. */
sig Person  {
	/* Each person tutors a set of persons. */
	Tutors : set Person,
	/* Each person teaches a set of classes. */
	Teaches : set Class
}
/* The registered groups. */
sig Group {}
/* The registered classes. */
sig Class  {
	/* Each class has a set of persons assigned to a group. */
	Groups : Person -> Group
}
/* Some persons are teachers. */
sig Teacher extends Person  {}
/* Some persons are students. */
sig Student extends Person  {}
/* Every person is a student. */
pred inv1 {
	Person in Student 
}
/* There are no teachers. */
pred inv2 {
	no Teacher 
}
/* No person is both a student and a teacher. */
pred inv3 {
	no Student & Teacher 
}
/* No person is neither a student nor a teacher. */
pred inv4 {
	Person in (Student + Teacher) 
}
/* There are some classes assigned to teachers. */
pred inv5 {
	some Teacher.Teaches 
}
/* Every teacher has classes assigned. */
pred inv6 {
	Teacher in Teaches.Class 
}
/* Every class has teachers assigned. */
pred inv7 {
	Class in Teacher.Teaches 
}
/* Teachers are assigned at most one class. */
pred inv8 {
	all t:Teacher | lone t.Teaches 
}
/* No class has more than one teacher assigned. */
pred inv9 {
	no c:Class | #((Teaches.c & Teacher).Tutors) > 1
}
/* For every class, every student has a group assigned. */
pred inv10 {
	all c:Class, s:Student | some s.(c.Groups) 
}
/* A class only has groups if it has a teacher assigned. */
pred inv11 {
	all c : Class | (some c.Groups) implies some Teacher & Teaches.c 
}
/* Each teacher is responsible for some groups. */
pred inv12 {
	all t : Teacher | some (t.Teaches).Groups 
}
/* Only teachers tutor, and only students are tutored. */
pred inv13 {
	Tutors.Person in Teacher and Person.Tutors in Student 
}
/* Every student in a class is at least tutored by all the teachers
 * assigned to that class. */
pred inv14 {
	all c : Class, s : Student | s in (Teacher & (Tutors . c)) implies s in (c . (Groups . Group))
}
/* The tutoring chain of every person eventually reaches a Teacher. */
pred inv15 {
	all s : Person | some Teacher & ^Tutors.s
}

/*==========================================*/

run inv1 for 5 but 5 Person
run inv2 for 5 but 5 Person, 4 Teacher
run inv3 for 5 but 5 Person, 4 Teacher
run inv4 for 5 but 5 Person, 4 Teacher
run inv5 for 5 but 5 Person, 4 Teacher, 3 Class, 1 Teacher.Teaches
run inv6 for 5 but 5 Person, 4 Teacher, 3 Class, 1 Teacher.Teaches
run inv7 for 5 but 5 Person, 4 Teacher, 3 Class, 1 Teacher.Teaches
run inv8 for 5 but 5 Person, 2 Teacher, 2 Teacher.Teaches
run inv9 for 5 but 5 Person, 2 Teacher, 2 Teacher.Teaches, 2 Class, 1 Class.Groups, Person = t1.Tutors.c1 + t2.Tutors.c2
run inv10 for 5 but 5 Person, 2 Teacher, 2 Teacher.Teaches, 2 Class, 2 Class.Groups, 3 Student, Person = s1.Groups.t1 + s2.Groups.t2 + s3.Groups.t2
run inv11 for 5 but 5 Person, 2 Teacher, 2 Teacher.Teaches, 2 Class, 2 Class.Groups, 3 Student, s1.Groups = s1.Groups.t1, s2.Groups = s2.Groups.t2 + s3.Groups.t2
run inv12 for 5 but 5 Person, 2 Teacher, 2 Teacher.Teaches, 2 Class, 2 Class.Groups, 2 Group
run inv13 for 5 but 5 Person, 2 Teacher, 2 Teacher.Teaches, 2 Class, 1 Class.Groups, 3 Group
run inv14 for 5 but 5 Person, 2 Teacher, 1 Teacher.Teaches, 1 Class, 2 Class.Groups, 3 Student, Person = s1.Groups.t1 + s2.Tutors.(Class -> one Group) + s3.Tutors.(Class -> one Group)
run inv15 for 5 but 5 Person, 2 Teacher, 1 Teacher.Teaches, 1 Class, Person = Tutors.s1 + Tutors.(Tutors.s1) + Tutors.(Tutors.(Tutors.s1)) + Teacher.((Tutors.s1) .* (Teaches.c1)) + Teacher.((Tutors.(Tutors.s1)) .* (Teaches.c1)) + (Teacher.*(Tutors.*(Tutors.*(Tutors.*(Tutors.*(Tutors.s1)))))).(Teaches.c1)