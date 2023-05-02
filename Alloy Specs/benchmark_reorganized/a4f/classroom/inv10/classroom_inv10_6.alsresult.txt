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
	Teacher in Teaches 
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
	all c:Class | lone c.Groups
}
/* For every class, every student has a group assigned. */
pred inv10 {
	all c: Class, s: Student | some c.Groups[s]
}
/* A class only has groups if it has a teacher assigned. */
pred inv11 {
	all c : Class | (some c.Groups) implies some t: Teacher | t in c.Teaches
}
/* Each teacher is responsible for some groups. */
pred inv12 {
	all t : Teacher | some c: Class, p: Person | c in t.Teaches and p in c.Groups[t]
}
/* Only teachers tutor, and only students are tutored. */
pred inv13 {
	all t: Teacher | all s: Student | t in s.Tutors
}
/* Every student in a class is at least tutored by all the teachers
 * assigned to that class. */
pred inv14 {
  all c:Class, s: Student, t: Teacher | c -> s in Class.Groups implies t -> c in Teacher.Teaches implies t -> s in Tutors[c]
}
/* The tutoring chain of every person eventually reaches a Teacher. */
pred inv15 {
	all s: Student | some t: Teacher | t in ^s.Tutors
} 

/*========== Perfect Oracle ===============*/ 
assert PerfectOracle {
	all disj i, j: Int | i <= j 
		=> (inv1 and inv2 and inv3 and inv4 and inv5 and inv6 and inv7 and inv8 and inv9 and inv10 and inv11 and inv12 and inv13 and inv14 and inv15) implies 
			(inv1_OK and inv2_OK and inv3_OK and inv4_OK and inv5_OK and inv6_OK and inv7_OK and inv8_OK and inv9_OK and inv10_OK and inv11_OK and inv12_OK and inv13_OK and inv14_OK and inv15_OK)
} 
run PerfectOracle for 5 but 10 Class, 10 Person, 5 Teacher, 20 Student, 1 Group assume exactly 2 Tutors, exactly 2 Teaches, exactly 2 Groups, exactly 3 Groups.Person.