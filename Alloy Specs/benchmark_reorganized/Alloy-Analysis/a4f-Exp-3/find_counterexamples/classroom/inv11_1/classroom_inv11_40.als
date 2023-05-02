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
/* Every person is a student or a teacher. */
pred inv1 {
	Person in (Student + Teacher)
}
/* All teachers have some classes assigned. */
pred inv2 {
	all t:Teacher | some t.Teaches
}
/* All classes have teachers assigned. */
pred inv3 {
	all c:Class | some t:Teacher | t->c in Teaches
}
/* Teachers are assigned at most one class. */
pred inv4 {
	all t:Teacher | lone t.Teaches
}
/* No class has more than one teacher assigned. */
pred inv5 {
	all c:Class | lone t:Teacher | t->c in Teaches
}
/* For every class, every student has a group assigned. */
pred inv6 {
	all c:Class, s:Student | some g:Group | (s->g) in c.Groups
}
/* A class only has groups if it has a teacher assigned. */
pred inv7 {
	all c:Class | (some g:Group | some t:Teacher | (t->c in Teaches && c -> t -> g in Groups)) implies some t:Teacher | t->c in Teaches
}
/* Teachers are responsible for some groups. */
pred inv8 {
	all t:Teacher | some cg:Class->Person->Group | t->(cg.Class) in Teaches && cg.Person in t.Tutors && cg.Person->cg.Group in (Class->Groups) 
}
/* Only teachers tutor, and only students are tutored. */
pred inv9 {
	all t:Teacher, s:Student | t.Tutors in Teacher && s.Tutors in Student
}
/* Every student in a class is at least tutored by one teacher assigned to that class. */
pred inv10 {
	all c:Class, s:Student | some t:Teacher | (t->c in Teaches && s in t.Tutors && (s->(_->c) in c.Groups))
}
/* The tutoring chain of every person eventually reaches a Teacher. */
pred inv11 {
	all s:Person | some t:Teacher | s in t.^Tutors
}

/*========= IFF PERFECT ORACLE ===============*/
pred inv1_OK {
	Person in (Student + Teacher)
}
assert inv1_Repaired {
	inv1[] iff inv1_OK[]
}

pred inv2_OK {
	all t:Teacher | some t.Teaches
}
assert inv2_Repaired {
	inv2[] iff inv2_OK[]
}

pred inv3_OK {
	all c:Class | some t:Teacher | t->c in Teaches
}
assert inv3_Repaired {
	inv3[] iff inv3_OK[]
}

pred inv4_OK {
	all t:Teacher | lone t.Teaches
}
assert inv4_Repaired {
	inv4[] iff inv4_OK[]
}

pred inv5_OK {
	all c:Class | lone t:Teacher | t->c in Teaches
}
assert inv5_Repaired {
	inv5[] iff inv5_OK[]
}

pred inv6_OK {
	all c:Class, s:Student | some g:Group | (s->g) in c.Groups
}
assert inv6_Repaired {
	inv6[] iff inv6_OK[]
}

pred inv7_OK {
	all c:Class | (some g:Group | some t:Teacher | (t->c in Teaches && c -> t -> g in Groups)) implies some t:Teacher | t->c in Teaches
}
assert inv7_Repaired {
	inv7[] iff inv7_OK[]
}

pred inv8_OK {
	all t:Teacher | some cg:Class->Person->Group | t->(cg.Class) in Teaches && cg.Person in t.Tutors && cg.Person->cg.Group in (Class->Groups) 
}
assert inv8_Repaired {
	inv8[] iff inv8_OK[]
}

pred inv9_OK {
	all t:Teacher, s:Student | t.Tutors in Teacher && s.Tutors in Student
}
assert inv9_Repaired {
	inv9[] iff inv9_OK[]
}

pred inv10_OK {
	all c:Class, s:Student | some t:Teacher | (t->c in Teaches && s in t.Tutors && (s->(_->c) in c.Groups))
}
assert inv10_Repaired {
	inv10[] iff inv10_OK[]
}

pred inv11_OK {
	all s:Person | some t:Teacher | s in t.^Tutors
}
assert inv11_Repaired {
	inv11[] iff inv11_OK[]
}

------ PerfectOracleCommands
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