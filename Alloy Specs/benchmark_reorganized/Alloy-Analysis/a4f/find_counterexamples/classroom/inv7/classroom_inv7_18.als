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
	Class in Teacher.Teaches <=> Class in Teaches.Class 
}
/* Teachers are assigned at most one class. */
pred inv8 {
	all t : Teacher | lone t.Teaches 
}
/* No class has more than one teacher assigned. */
pred inv9 {
	all c : Class | lone t : Teacher | t -> c in Teaches
}
/* For every class, every student has a group assigned. */
pred inv10 {
	all c : Class, s : Student | some s.(c.Groups)
}
/* A class only has groups if it has a teacher assigned. */
pred inv11 {
	all c : Class | (some c.Groups) implies some Teacher & Teaches.c
}
/* Each teacher is responsible for some groups. */
pred inv12 {
	all t : Teacher | some t.Teaches.Groups
}
/* Only teachers tutor, and only students are tutored. */
pred inv13 {
	all p : Person | p.Tutors in Teacher and p.Tutors in Student
}
/* Every student in a class is tutored by at least one teacher assigned to that class. */
pred inv14 {
	all c : Class, s : Student | (some t : Teacher | t -> c in Teaches and s -> (c.Groups).t in Tutors)
}
/* The tutoring chain of every person eventually reaches a Teacher. */
pred inv15 {
	all s : Person | some t : Teacher | t in ^s.Tutors
}

/* Checking repaired invariants against the original ones */
pred invariant_check {
    inv1[] iff inv1_OK[] and 
    inv2[] iff inv2_OK[] and 
    inv3[] iff inv3_OK[] and 
    inv4[] iff inv4_OK[] and 
    inv5[] iff inv5_OK[] and 
    inv6[] iff inv6_OK[] and 
    inv7[] iff inv7_OK[] and 
    inv8[] iff inv8_OK[] and 
    inv9[] iff inv9_OK[] and 
    inv10[] iff inv10_OK[] and 
    inv11[] iff inv11_OK[] and 
    inv12[] iff inv12_OK[] and 
    inv13[] iff inv13_OK[] and 
    inv14[] iff inv14_OK[] and 
    inv15[] iff inv15_OK[]
}

/* perfect oracle commands */
check invariant_check
