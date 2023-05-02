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
/* No class has more than a teacher assigned. */
pred inv9 {
	all c:Class | lone c.Teaches & Teacher 
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
	all c : Class | all s : c.Groups.Person | some c.Teaches.Tutors & s in c.Teaches.Tutors and s.Tutors in c.Teaches.Tutors 
}
/* The tutoring chain of every person eventually reaches a Teacher. */
pred inv15 {
	all s : Person | some Teacher & ^Tutors.s
}

/* Repair predicates */
pred inv14_OK {
	all c : Class | all s : c.Groups.Person | (some (c.Teaches & Teacher)).Tutors & s in (c.Teaches & Teacher).Tutors and s.Tutors in (c.Teaches & Teacher).Tutors 
}

/* Repair assertions */
assert inv14_Repaired {
	inv14[] iff inv14_OK[]
}

/* Check all assertions */
run inv14_Repaired for 5 but 5 Class, exactly 10 Person, exactly 5 Teacher, exactly 20 Group, exactly 15 Tutors, exactly 15 Teaches, exactly 200 Groups_Person, exactly 500 Classes, exactly 1000 Persons, exactly 2000 Groups, exactly 3000 Teaches_Class, exactly 2000 Teachers, exactly 3000 Tutors_Person, exactly 100000 Groups_Person_Group
check inv14_Repaired for 5 but 5 Class, exactly 10 Person, exactly 5 Teacher, exactly 20 Group, exactly 15 Tutors, exactly 15 Teaches, exactly 200 Groups_Person, exactly 500 Classes, exactly 1000 Persons, exactly 2000 Groups, exactly 3000 Teaches_Class, exactly 2000 Teachers, exactly 3000 Tutors_Person, exactly 100000 Groups_Person_Group
