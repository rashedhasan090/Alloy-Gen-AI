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
pred inv1_OK {
	Person in Student 
}
/* There are no teachers. */
pred inv2_OK {
	no Teacher 
}
/* No person is both a student and a teacher. */
pred inv3_OK {
	no Student & Teacher 
}
/* No person is neither a student nor a teacher. */
pred inv4_OK {
	Person in (Student + Teacher)
}
/* There are some classes assigned to teachers. */
pred inv5_OK {
	some Teacher.Teaches 
}
/* Every teacher has classes assigned. */
pred inv6_OK {
	all t:Teacher | t.Teaches != none
}
/* Every class has teachers assigned. */
pred inv7_OK {
	all c:Class | c.Teaches != none
}
/* Teachers are assigned at most one class. */
pred inv8_OK {
	all t:Teacher | lone t.Teaches
}
/* No class has more than one teacher assigned. */
pred inv9_OK {
	all c:Class | lone t:Teacher | t -> c in Teaches
}
/* For every class, every student has a group assigned. */
pred inv10_OK {
	all c:Class, s:Student | some g:Group | g = c.Groups.s
}
/* A class only has groups if it has a teacher assigned. */
pred inv11_OK {
	all c : Class | (some c.Groups) implies some t : Teacher | t -> c in Teaches
}
/* Each teacher is responsible for some groups. */
pred inv12_OK {
	all t : Teacher | some c : t.Teaches | some g : Group | g = c.Groups[t]
}
/* Only teachers tutor, and only students are tutored. */
pred inv13_OK {
	all p:Person | (p.Tutors = none) != (p in Teacher)
}
/* Every student in a class is tutored by all the teachers assigned to that class. */
pred inv14_OK {
	all c:Class, s:Student |
		let assignedTeachers = {t : Teacher | t -> c in Teaches} |
		all t:assignedTeachers | s in t.Tutors
}
/* The tutoring chain of every person eventually reaches a Teacher. */
pred inv15_OK {
	all p:Person | Teacher in p.^Tutors
}

/* Repairs */
fact Repair_School {
    inv1_OK
    inv2_OK
    inv3_OK
    inv4_OK
    inv5_OK
    inv6_OK
    inv7_OK
    inv8_OK
    inv9_OK
    inv10_OK
    inv11_OK
    inv12_OK
    inv13_OK
    inv14_OK
    inv15_OK
}

/* Check Repaired Invariants */
assert RepairedInvariants {
    all disj inv: Predicate | inv in inv1_OK + inv2_OK + inv3_OK + inv4_OK + inv5_OK + inv6_OK + inv7_OK + inv8_OK + inv9_OK + inv10_OK + inv11_OK + inv12_OK + inv13_OK + inv14_OK + inv15_OK => inv_Repaired[inv]
}

/* Check Original Invariants */
check OriginalInvariants {
    all disj inv: Predicate | inv in inv1 + inv2 + inv3 + inv4 + inv5 + inv6 + inv7 + inv8 + inv9 + inv10 + inv11 + inv12 + inv13 + inv14 + inv15 => inv_Repaired[inv]
}