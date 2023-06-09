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
	Teacher.Teaches in Class 
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
	all c:Class | lone t:Teacher | t in Teaches.c 
}
/* For every class, every student has a group assigned. */
pred inv10 {
	all c:Class, s:Student | some g:Group | (c.Groups[s] = g)
}
/* A class only has groups if it has a teacher assigned. */
pred inv11 {
	all g:Group, c:Class | some p:Person | (c.Groups[p] = g) implies p in Teacher   
}
/* Each teacher is responsible for some groups. */
pred inv12 {
	all t : Teacher | some (t.Teaches).Groups 
}
/* Only teachers tutor, and only students are tutored. */
pred inv13 {
	Tutors.Person = Teacher and Student in Tutors 
}
/* Every student in a class is at least tutored by all the teachers
 * assigned to that class. */
pred inv14 {
	all s : Person, c : Class, t : Person, g : Group | (c.Groups[s] = g) and t in Teaches.c implies s in t.Tutors
}
/* The tutoring chain of every person eventually reaches a Teacher. */
pred inv15 {
	all s : Person | some Teacher & ^Tutors.s
}

/*Modified Assertions*/
assert inv6_Repaired {
    inv6[] iff inv6_OK[]
}

assert inv9_Repaired {
    inv9[] iff inv9_OK[]
}

assert inv10_Repaired {
    inv10[] iff inv10_OK[]
}

assert inv11_Repaired {
    inv11[] iff inv11_OK[]
}

/* PerfectOracleCommands */
check inv1 expect 0
check inv2 expect 0
check inv3 expect 0
check inv4 expect 0
check inv5 expect 0
check inv6_Repaired expect 0
check inv7 expect 0
check inv8 expect 0
check inv9_Repaired expect 0
check inv10_Repaired expect 0
check inv11_Repaired expect 0
check inv12 expect 0
check inv13 expect 0
check inv14 expect 0
check inv15 expect 0