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
	Class in Teaches.Class
}
/* Teachers are assigned at most one class. */
pred inv8 {
	all t:Teacher | lone t.Teaches 
}
/* No class has more than one teacher assigned. */
pred inv9 {
	all c:Class | lone Teachers.c 
}
/* For every class, every student has a group assigned. */
pred inv10 {
	all c:Class, s:Student | some s.(c.Groups) 
}
/* A class only has groups if it has a teacher assigned. */
pred inv11 {
	all c : Class | (some c.Groups) implies some t : Teacher | t.Teaches = c 
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
	all s : Person | some Teacher & s.^Tutors 
}

/* Repair predicates to check if the fixed version satisfies the original assertions */

pred inv1_Repaired {
  Person in Student 
}

assert inv1_Fixed {
    inv1[] iff inv1_Repaired[]
}

pred inv2_Repaired {
  no Teacher 
}

assert inv2_Fixed {
    inv2[] iff inv2_Repaired[]
}

pred inv3_Repaired {
  no Student & Teacher 
}

assert inv3_Fixed {
    inv3[] iff inv3_Repaired[]
}

pred inv4_Repaired {
  Person in (Student + Teacher) 
}

assert inv4_Fixed {
    inv4[] iff inv4_Repaired[]
}

pred inv5_Repaired {
  some Teacher.Teaches 
}

assert inv5_Fixed {
    inv5[] iff inv5_Repaired[]
}

pred inv6_Repaired {
  Teacher in Teaches
}

assert inv6_Fixed {
    inv6[] iff inv6_Repaired[]
}

pred inv7_Repaired {
  Class in Teaches.Class
}

assert inv7_Fixed {
    inv7[] iff inv7_Repaired[]
}

pred inv8_Repaired {
  all t:Teacher | lone t.Teaches 
}

assert inv8_Fixed {
    inv8[] iff inv8_Repaired[]
}

pred inv9_Repaired {
  all c:Class | lone Teachers.c 
}

assert inv9_Fixed {
    inv9[] iff inv9_Repaired[]
}

pred inv10_Repaired {
  all c:Class, s:Student | some s.(c.Groups) 
}

assert inv10_Fixed {
    inv10[] iff inv10_Repaired[]
}

pred inv11_Repaired {
  all c : Class | (some c.Groups) implies some t : Teacher | t.Teaches = c 
}

assert inv11_Fixed {
    inv11[] iff inv11_Repaired[]
}

pred inv12_Repaired {
 all t : Teacher | some (t.Teaches).Groups 
}

assert inv12_Fixed {
    inv12[] iff inv12_Repaired[]
}

pred inv13_Repaired {
  Tutors.Person in Teacher and Person.Tutors in Student  
}

assert inv13_Fixed {
    inv13[] iff inv13_Repaired[]
}

pred inv14_Repaired {
      all s : Person, c : Class, t : Person, g : Group | (c -> s -> g in Groups) and t -> c in Teaches implies t -> s in Tutors 
}

assert inv14_Fixed {
    inv14[] iff inv14_Repaired[]
}

pred inv15_Repaired {
  all s : Person | some Teacher & ^Tutors.s 
}

assert inv15_Fixed {
    inv15[] iff inv15_Repaired[]
}

check inv1_Fixed expect 0
check inv2_Fixed expect 0
check inv3_Fixed expect 0 
check inv4_Fixed expect 0
check inv5_Fixed expect 0
check inv6_Fixed expect 0
check inv7_Fixed expect 0
check inv8_Fixed expect 0
check inv9_Fixed expect 0
check inv10_Fixed expect 0
check inv11_Fixed expect 0
check inv12_Fixed expect 0
check inv13_Fixed expect 0
check inv14_Fixed expect 0
check inv15_Fixed expect 0