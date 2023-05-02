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
	some c:Class | some c.Teaches 
}
/* Every teacher has classes assigned. */
pred inv6 {
	all t:Teacher | some c:Class | c in t.Teaches
}
/* Every class has teachers assigned. */
pred inv7 {
	all c:Class | some t:Teacher | t in c.Teaches
}
/* Teachers are assigned at most one class. */
pred inv8 {
	all t:Teacher | lone t.Teaches
}
/* No class has more than one teacher assigned. */
pred inv9 {
	all c:Class | lone t:Teacher | t in c.Teaches
}
/* For every class, every student has a group assigned. */
pred inv10 {
	all c:Class, s:Student | some g:Group | (s->g) in c.Groups 
}
/* A class only has groups if it has a teacher assigned. */
pred inv11 {
	all c:Class | some t:Teacher | t in c.Teaches implies some g:Group | (t->g) in c.Groups
}
/* Each teacher is responsible for some groups. */
pred inv12 {
	all t:Teacher | some c:Class, g:Group | c in t.Teaches and (t->g) in c.Groups
}
/* Only teachers tutor, and only students are tutored. */
pred inv13 {
	all p:Person | p in Teacher.Tutors iff p in Teacher and p.Tutors in Student
}
/* Every student in a class is tutored by at least one teacher assigned to that class. */
pred inv14 {
	all c:Class, s:Student | some t:Teacher | (t->s) in c.Tutors
}
/* The tutoring chain of every person eventually reaches a Teacher. */
pred inv15 {
	all s:Person | some t:Teacher | t in ^s.Tutors
}

/* Repaired assertions */
pred inv1_Repaired {
  Person in Student
}
assert inv1AssertionRepaired {
    inv1[] iff inv1_Repaired[]
}

pred inv2_Repaired {
  no Teacher
}
assert inv2AssertionRepaired {
    inv2[] iff inv2_Repaired[]
}

pred inv3_Repaired {
  no Student & Teacher
}
assert inv3AssertionRepaired {
    inv3[] iff inv3_Repaired[]
}

pred inv4_Repaired {
 Person in (Student + Teacher)
}
assert inv4AssertionRepaired{
    inv4[] iff inv4_Repaired[]
}

pred inv5_Repaired {
  some c:Class | some c.Teaches 
}
assert inv5AssertionRepaired{
    inv5[] iff inv5_Repaired[]
}

pred inv6_Repaired {
  all t:Teacher | some c:Class | c in t.Teaches
}
assert inv6AssertionRepaired{
    inv6[] iff inv6_Repaired[]
}

pred inv7_Repaired {
  all c:Class | some t:Teacher | t in c.Teaches
}
assert inv7AssertionRepaired{
    inv7[] iff inv7_Repaired[]
}

pred inv8_Repaired {
  all t:Teacher | lone t.Teaches
}
assert inv8AssertionRepaired{
    inv8[] iff inv8_Repaired[]
}

pred inv9_Repaired {
  all c:Class | lone t:Teacher | t in c.Teaches
}
assert inv9AssertionRepaired{
    inv9[] iff inv9_Repaired[]
}

pred inv10_Repaired {
  all c:Class, s:Student | some g:Group | (s->g) in c.Groups 
}
assert inv10AssertionRepaired{
    inv10[] iff inv10_Repaired[]
}

pred inv11_Repaired {
  all c:Class | some t:Teacher | t in c.Teaches implies some g:Group | (t->g) in c.Groups
}
assert inv11AssertionRepaired{
    inv11[] iff inv11_Repaired[]
}

pred inv12_Repaired {
 all t:Teacher | some c:Class, g:Group | c in t.Teaches and (t->g) in c.Groups
}
assert inv12AssertionRepaired{
    inv12[] iff inv12_Repaired[]
}

pred inv13_Repaired {
  all p:Person | p in Teacher.Tutors iff p in Teacher and p.Tutors in Student
}
assert inv13AssertionRepaired{
    inv13[] iff inv13_Repaired[]
}

pred inv14_Repaired {
      all c:Class, s:Student | some t:Teacher | (t->s) in c.Tutors
}
assert inv14AssertionRepaired{
    inv14[] iff inv14_Repaired[]
}

pred inv15_Repaired {
  all s:Person | some t:Teacher | t in ^s.Tutors
}
assert inv15AssertionRepaired{
    inv15[] iff inv15_Repaired[]
}

/* Repaired assertions */

check inv1AssertionRepaired
check inv2AssertionRepaired
check inv3AssertionRepaired
check inv4AssertionRepaired
check inv5AssertionRepaired
check inv6AssertionRepaired
check inv7AssertionRepaired
check inv8AssertionRepaired
check inv9AssertionRepaired
check inv10AssertionRepaired
check inv11AssertionRepaired
check inv12AssertionRepaired
check inv13AssertionRepaired
check inv14AssertionRepaired
check inv15AssertionRepaired

/* Removal of unused/irrelevant code */
sig Person  {
	Tutors : set Person,
	Teaches : set Class
}
sig Group {}
sig Class  {
	Groups : Person -> Group
}
sig Teacher extends Person  {}
sig Student extends Person  {}

pred inv1 {
	Person in Student
}
pred inv2 {
	no Teacher
}
pred inv3 {
	no Student & Teacher
}
pred inv4 {
	Person in (Student + Teacher)
}
pred inv5 {
	some c:Class | some c.Teaches 
}
pred inv6 {
	all t:Teacher | some c:Class | c in t.Teaches
}
pred inv7 {
	all c:Class | some t:Teacher | t in c.Teaches
}
pred inv8 {
	all t:Teacher | lone t.Teaches
}
pred inv9 {
	all c:Class | lone t:Teacher | t in c.Teaches
}
pred inv10 {
	all c:Class, s:Student | some g:Group | (s->g) in c.Groups 
}
pred inv11 {
	all c:Class | some t:Teacher | t in c.Teaches implies some g:Group | (t->g) in c.Groups
}
pred inv12 {
	all t:Teacher | some c:Class, g:Group | c in t.Teaches and (t->g) in c.Groups
}
pred inv13 {
	all p:Person | p in Teacher.Tutors iff p in Teacher and p.Tutors in Student
}
pred inv14 {
	all c:Class, s:Student | some t:Teacher | (t->s) in c.Tutors
}
pred inv15 {
	all s:Person | some t:Teacher | t in ^s.Tutors
}

check inv1
check inv2
check inv3
check inv4
check inv5
check inv6
check inv7
check inv8
check inv9
check inv10
check inv11
check inv12
check inv13
check inv14
check inv15