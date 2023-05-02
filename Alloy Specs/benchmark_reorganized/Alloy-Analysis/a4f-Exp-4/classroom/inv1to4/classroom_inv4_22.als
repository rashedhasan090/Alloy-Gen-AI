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
assert inv1_Repaired {
    inv1[] iff inv1_OK[]
}

/* There are no teachers. */
pred inv2_OK {
	no Teacher 
}
assert inv2_Repaired {
    inv2[] iff inv2_OK[]
}

/* No person is both a student and a teacher. */
pred inv3_OK {
	no Student & Teacher 
}
assert inv3_Repaired {
    inv3[] iff inv3_OK[]
}

/* Every person is either a student or a teacher. */
pred inv4_OK {
	all p:Person | p in Student or p in Teacher
}
assert inv4_Repaired {
    inv4[] iff inv4_OK[]
}

/* Some persons are assigned to classes as teachers. */
pred inv5_OK {
	some Teacher.Teaches 
}
assert inv5_Repaired {
    inv5[] iff inv5_OK[]
}

/* Every teacher has at least one class assigned. */
pred inv6_OK {
	all t:Teacher | some c:Class | c in t.Teaches
}
assert inv6_Repaired {
    inv6[] iff inv6_OK[]
}

/* Every class has at least one teacher assigned. */
pred inv7_OK {
	all c:Class | some t:Teacher | t in c.Teaches
}
assert inv7_Repaired {
    inv7[] iff inv7_OK[]
}

/* Every teacher is assigned at most one class. */
pred inv8_OK {
	all t:Teacher | lone t.Teaches 
}
assert inv8_Repaired {
    inv8[] iff inv8_OK[]
}

/* No class has more than one teacher assigned. */
pred inv9_OK {
	all c:Class | lone t:Teacher | t in c.Teaches
}
assert inv9_Repaired {
    inv9[] iff inv9_OK[]
}

/* Every student in a class is assigned to at least one group. */
pred inv10_OK {
	all c:Class, s:Student | some g:Group | (s -> g) in c.Groups
}
assert inv10_Repaired {
    inv10[] iff inv10_OK[]
}

/* A class has at least one group assigned if it has a teacher assigned. */
pred inv11_OK {
	all c:Class | not (some t:Teacher | t in c.Teaches) or (some g:Group | g in c.Groups)
}
assert inv11_Repaired {
    inv11[] iff inv11_OK[]
}

/* Each teacher is assigned at least one group through the classes they teach. */
pred inv12_OK {
	all t:Teacher | some c:Class | c in t.Teaches and (some g:Group | g in c.Groups)
}
assert inv12_Repaired {
    inv12[] iff inv12_OK[]
}

/* Only teachers tutor, and only students are tutored. */
pred inv13_OK {
	all p:Person | (p in Teacher) xor (p in p.Tutors.Student)
}
assert inv13_Repaired {
    inv13[] iff inv13_OK[]
}

/* Every student in a class is tutored by at least one teacher assigned to that class. */
pred inv14_OK {
	all c:Class, s:Student | some t:Teacher | t in c.Teaches and (s -> c -> t) in Tutors
}
assert inv14_Repaired {
    inv14[] iff inv14_OK[]
}

/* The tutoring chain of every person eventually reaches a Teacher. */
pred inv15_OK {
	all p:Person | some t:Teacher | t in ^p.Tutors
}
assert inv15_Repaired {
    inv15[] iff inv15_OK[]
}

/* PerfectOracleCommands */
check inv1_Repaired expect 0
check inv2_Repaired expect 0
check inv3_Repaired expect 0 
check inv4_Repaired expect 0
check inv5_Repaired expect 0
check inv6_Repaired expect 0
check inv7_Repaired expect 0
check inv8_Repaired expect 0
check inv9_Repaired expect 0
check inv10_Repaired expect 0
check inv11_Repaired expect 0
check inv12_Repaired expect 0
check inv13_Repaired expect 0
check inv14_Repaired expect 0
check inv15_Repaired expect 0