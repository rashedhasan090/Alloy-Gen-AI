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
	Groups : Person lone -> Group
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
/* No class has more than one teacher assigned. */
pred inv9 {
	all c:Class | lone t:Teacher | t -> c in Teaches 
}
/* For every class, every student has a group assigned. */
pred inv10 {
	all c:Class, s:Student | some s.(c.Groups) 
}
/* A class only has groups if it has a teacher assigned. */
pred inv11 {
	all c : Class | some t : Teacher | c->t->one.Groups implies t->c in Teaches
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
	all s : Person | some Teacher & ^Tutors.s
}
/* IFF PERFECT ORACLE*/
pred inv1_perfect {
  Person in Student 
}
pred inv2_perfect {
  no Teacher 
}
pred inv3_perfect {
  no Student & Teacher 
}
pred inv4_perfect {
  Person in (Student + Teacher) 
}
pred inv5_perfect {
  some Teacher.Teaches 
}
pred inv6_perfect {
  Teacher in Teaches.Class 
}
pred inv7_perfect {
  Class in Teacher.Teaches 
}
pred inv8_perfect {
  all t:Teacher | lone t.Teaches 
}
pred inv9_perfect {
  all c:Class | lone t:Teacher | t -> c in Teaches 
}
pred inv10_perfect {
  all c:Class, s:Student | some s.(c.Groups) 
}
pred inv11_perfect {
  all c : Class | some t : Teacher | c->t->one.Groups implies t->c in Teaches
}
pred inv12_perfect {
  all t : Teacher | some (t.Teaches).Groups 
}
pred inv13_perfect {
  Tutors.Person in Teacher and Person.Tutors in Student 
}
pred inv14_perfect {
  all s : Person, c : Class, t : Person, g : Group | (c -> s -> g in Groups) and t -> c in Teaches implies t -> s in Tutors 
}
pred inv15_perfect {
  all s : Person | some Teacher & ^Tutors.s 
}
assert Inv_PerfectOracle{ inv1[] iff inv1_perfect[] and inv2[] iff inv2_perfect[] and inv3[] iff inv3_perfect[] and inv4[] iff inv4_perfect[] and inv5[] iff inv5_perfect[] and inv6[] iff inv6_perfect[] and inv7[] iff inv7_perfect[] and inv8[] iff inv8_perfect[] and inv9[] iff inv9_perfect[] and inv10[] iff inv10_perfect[] and inv11[] iff inv11_perfect[] and inv12[] iff inv12_perfect[] and inv13[] iff inv13_perfect[] and inv14[] iff inv14_perfect[] and inv15[] iff inv15_perfect[] }
check Inv_PerfectOracle expect 0