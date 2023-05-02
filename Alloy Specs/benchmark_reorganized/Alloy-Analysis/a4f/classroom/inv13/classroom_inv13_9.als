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
	Teacher.Teaches = Class
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
	no disjoint[c1, c2:Class, t:Teacher | t in c1.Teaches and t in c2.Teaches and c1 != c2]
}
/* For every class, every student has a group assigned. */
pred inv10 {
	all c:Class, s:Student | some s.(c.Groups)
}
/* A class only has groups if it has a teacher assigned. */
pred inv11 {
	all c, g:Group | g in c.Groups.Person.Tutors.Teaches[c] implies c.Teaches
}
/* Each teacher is responsible for some groups. */
pred inv12 {
	all t:Teacher | some t.Teaches.Groups
}
/* Only teachers tutor, and only students are tutored. */
pred inv13 {
	all s:Student, t:Teacher | s not in t.Tutors and t not in s.Tutors
}
/* Every student in a class is at least tutored by all the teachers
 * assigned to that class. */
pred inv14 {
	all c:Class, s:Student | s in c.Groups.Person.Tutors.Teaches[c].Tutors
}
/* The tutoring chain of every person eventually reaches a Teacher. */
pred inv15 {
	all s:Person | some s.^Tutors.Teacher
}

/* Repaired invariant predicates */
pred inv1_Repaired {
  Person in Student 
}

pred inv2_Repaired {
  no Teacher 
}

pred inv3_Repaired {
  no Student & Teacher
}

pred inv4_Repaired {
 Person in (Student + Teacher) 
}

pred inv5_Repaired {
  some Teacher.Teaches 
}

pred inv6_Repaired {
  Teacher.Teaches = Class
}

pred inv7_Repaired {
  Class in Teacher.Teaches
}

pred inv8_Repaired {
  all t:Teacher | lone t.Teaches
}

pred inv9_Repaired {
  no disjoint[c1, c2:Class, t:Teacher | t in c1.Teaches and t in c2.Teaches and c1 != c2]
}

pred inv10_Repaired {
  all c:Class, s:Student | some s.(c.Groups)
}

pred inv11_Repaired {
  all c, g:Group | g in c.Groups.Person.Tutors.Teaches[c] implies c.Teaches
}

pred inv12_Repaired {
  all t:Teacher | some t.Teaches.Groups
}

pred inv13_Repaired {
  all s:Student, t:Teacher | s not in t.Tutors and t not in s.Tutors
}

pred inv14_Repaired {
  all c:Class, s:Student | s in c.Groups.Person.Tutors.Teaches[c].Tutors
}

pred inv15_Repaired {
  all s:Person | some s.^Tutors.Teacher
}

/* Repairing each invariant predicate */
assert inv1 {
    inv1[] iff inv1_Repaired[]
}

assert inv2 {
    inv2[] iff inv2_Repaired[]
}

assert inv3 {
    inv3[] iff inv3_Repaired[]
}

assert inv4 {
    inv4[] iff inv4_Repaired[]
}

assert inv5 {
    inv5[] iff inv5_Repaired[]
}

assert inv6 {
    inv6[] iff inv6_Repaired[]
}

assert inv7 {
    inv7[] iff inv7_Repaired[]
}

assert inv8 {
    inv8[] iff inv8_Repaired[]
}

assert inv9 {
    inv9[] iff inv9_Repaired[]
}

assert inv10 {
    inv10[] iff inv10_Repaired[]
}

assert inv11 {
    inv11[] iff inv11_Repaired[]
}

assert inv12 {
    inv12[] iff inv12_Repaired[]
}

assert inv13 {
    inv13[] iff inv13_Repaired[]
}

assert inv14 {
    inv14[] iff inv14_Repaired[]
}

assert inv15 {
    inv15[] iff inv15_Repaired[]
}