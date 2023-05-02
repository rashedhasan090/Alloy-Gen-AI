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
	all c:Class | lone (c.Teaches & Teacher) 
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
	all s : Student, c : Class | c.Teaches & Teacher in s.Tutors => s in c.Groups.(c.Teaches & Teacher)
}
/* The tutoring chain of every person eventually reaches a Teacher. */
pred inv15 {
	all s : Person | some Teacher & ^Tutors.s
}

/*===========================*/
/*Iff Perfect Oracle Commands*/
/*===========================*/

/* Repaired Predicate */
pred inv14_Repaired {
	all s : Student, c : Class | c.Teaches & Teacher in s.Tutors => s in c.Groups.(c.Teaches & Teacher)
}

/* Assert the Repaired Predicate */
assert inv14_Iff_PerfectOracle {
	inv14[] iff inv14_Repaired[]
}

/* Check the Repaired Assertions */
check inv1 expect 0
check inv2 expect 0
check inv3 expect 0
check inv4 expect 0
check inv5 expect 0
check inv6 expect 0
check inv7 expect 0
check inv8 expect 0
check inv9 expect 0
check inv10 expect 0
check inv11 expect 0
check inv12 expect 0
check inv13 expect 0
check inv14_Iff_PerfectOracle expect 0
check inv15 expect 0

/* Repair Commands */
pred repair {
	inv14_Repaired[]
}

/* Run the Repair Commands */
run repair

/* Assert the Repair Commands */
assert repair_assert {
	inv14[] iff inv14_Repaired[]
}

/* Check the Repair Assertions */
check repair_assert