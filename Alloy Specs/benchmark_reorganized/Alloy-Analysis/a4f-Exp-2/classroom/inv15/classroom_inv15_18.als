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
	all c:Class | lone Teaches[c] & Teacher 
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
	all s : Person, c : Class, t : Person, g : Group | (c -> s -> g in Groups) and t -> c in Teaches implies t -> s in Tutors
}
/* The tutoring chain of every person eventually reaches a Teacher. */
pred inv15 {
	all p,q,r : Person | (p->q in Tutors or q->r in Tutors or p->r in Tutors) implies (p in Teacher or q in Teacher or r in Teacher) 
}

/* IFF PERFECT ORACLE */
pred inv1_OK {
	Person in Student 
}

pred inv2_OK {
	no Teacher 
}

pred inv3_OK {
	no Student & Teacher 
}

pred inv4_OK {
	Person in (Student + Teacher) 
}

pred inv5_OK {
	some Teacher.Teaches 
}

pred inv6_OK {
	Teacher in Teaches.Class 
}

pred inv7_OK {
	Class in Teacher.Teaches 
}

pred inv8_OK {
	all t:Teacher | lone t.Teaches 
}

pred inv9_OK {
	all c:Class | lone Teaches[c] & Teacher 
}

pred inv10_OK {
	all c:Class, s:Student | some s.(c.Groups) 
}

pred inv11_OK {
	all c : Class | (some c.Groups) implies some Teacher & Teaches.c 
}

pred inv12_OK {
	all t : Teacher | some (t.Teaches).Groups 
}

pred inv13_OK {
	Tutors.Person in Teacher and Person.Tutors in Student 
}

pred inv14_OK {
	all s : Person, c : Class, t : Person, g : Group | (c -> s -> g in Groups) and t -> c in Teaches implies t -> s in Tutors 
}

pred inv15_OK {
	all s : Person | some Teacher & ^Tutors.s 
}

assert PerfectOracleAssertions {
	all p : Person | (
		(p in Student) and
		(p in Tutors.Person implies p in Teacher) and
		(p in Teacher implies p in Tutors.Person) and
		(p in Student implies p.Teaches = {}) and
		(all t : Teacher | (t in p.Tutors.Person) iff (t.Teaches & p.Teaches != {})) and
		(all c : Class | (c in p.Teaches) implies some s : p.Tutors.Person | (c -> s -> _) in c.Groups))
	}

assert PerfectOracle {
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

run PerfectOracle for 2 alcube, 5 int, 5 seq, 5 str

pred repair_pred_1 {
	inv15[] iff inv15_OK[] 
}

run repair_pred_1 for 2 alcube, 5 int, 5 seq, 5 str

assert repair_assert_1 {
	inv15[] iff inv15_OK[] 
}

check repair_assert_1