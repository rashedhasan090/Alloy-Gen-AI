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
	Teacher in Teaching.Teaches.Class 
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
	all c:Class | lone Teaches.c & Teacher
}
/* For every class, every student has a group assigned. */
pred inv10 {
	all c:Class, s:Student | some s.(c.Groups)
}
/* A class only has groups if it has a teacher assigned. */
pred inv11 {
	all c : Class | (some c.Groups) implies some Teacher & Teaching.c 
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

/* Repaired assertions with Ok tests */
pred inv1_Ok {
  Person in Student
}
assert inv1_repaired {
inv1[] iff inv1_Ok[]
}

pred inv2_Ok {
  no Teacher
}
assert inv2_repaired {
inv2[] iff inv2_Ok[]
}

pred inv3_Ok {
  no Student & Teacher
}
assert inv3_repaired {
inv3[] iff inv3_Ok[]
}

pred inv4_Ok {
  Person in (Student + Teacher)
}
assert inv4_repaired {
inv4[] iff inv4_Ok[]
}

pred inv5_Ok {
  some Teacher.Teaches
}
assert inv5_repaired {
inv5[] iff inv5_Ok[]  
}

pred inv6_Ok {
  Teacher in Teaching.Teaches.Class 
}
assert inv6_repaired {
inv6[] iff inv6_Ok[]
}

pred inv7_Ok {
  Class in Teacher.Teaches 
}
assert inv7_repaired {
inv7[] iff inv7_Ok[]
}

pred inv8_Ok {
  all t:Teacher | lone t.Teaches
}
assert inv8_repaired {
inv8[] iff inv8_Ok[]
}

pred inv9_Ok {
  all c:Class | lone Teaches.c & Teacher
}
assert inv9_repaired {
inv9[] iff inv9_Ok[]
}

pred inv10_Ok {
  all c:Class, s:Student | some s.(c.Groups)
}
assert inv10_repaired {
inv10[] iff inv10_Ok[]
}

pred inv11_Ok {
  all c : Class | (some c.Groups) implies some Teacher & Teaching.c 
}
assert inv11_repaired {
inv11[] iff inv11_Ok[]
}

pred inv12_Ok {
  all t : Teacher | some (t.Teaches).Groups
}
assert inv12_repaired {
inv12[] iff inv12_Ok[]
}

pred inv13_OK{
  Tutors.Person in Teacher and Person.Tutors in Student
}
assert inv13_repaired{
  inv13[] iff inv13_OK[]
}

pred inv14_Ok {
      all s : Person, c : Class, t : Person, g : Group | (c -> s -> g in Groups) and t -> c in Teaches implies t -> s in Tutors
}
assert inv14_repaired {
inv14[] iff inv14_Ok[]
}

pred inv15_Ok {
  all s : Person | some Teacher & ^Tutors.s
}
assert inv15_repaired {
inv15[] iff inv15_Ok[]
}

/* IFF perfect oracle bindings*/

check inv1_repaired expect 0
check inv2_repaired expect 0
check inv3_repaired expect 0
check inv4_repaired expect 0
check inv5_repaired expect 0
check inv6_repaired expect 0
check inv7_repaired expect 0
check inv8_repaired expect 0
check inv9_repaired expect 0
check inv10_repaired expect 0
check inv11_repaired expect 0
check inv12_repaired expect 0
check inv13_repaired expect 0
check inv14_repaired expect 0
check inv15_repaired expect 0
