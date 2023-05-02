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
	Teacher in Teaches.Class 
}
/* Every class has teachers assigned. */
pred inv7_OK {
	all c:Class | some t:Teacher | t in c.Teaches
}
/* Teachers are assigned at most one class. */
pred inv8_OK {
	all t:Teacher | lone t.Teaches 
}
/* No class has more than one teacher assigned. */
pred inv9_OK {
	all c:Class | lone t:Teacher | t in c.Teaches 
}
/* For every class, every student has a group assigned. */
pred inv10_OK {
	all c:Class, s:Student | some g:c.Groups[s] 
}
/* A class only has groups if it has a teacher assigned. */
pred inv11_OK {
	all c : Class | some t : Teacher | t in c.Teaches implies some g : c.Groups | g in t.Tutors
}
/* Each teacher is responsible for some groups. */
pred inv12_OK {
	all t : Teacher | some g : Group | g in t.Tutors.Groups
}
/* Only teachers tutor, and only students are tutored. */
pred inv13_OK {
	Tutors.Person in Teacher and Person.Tutors in Student 
}
/* Every student in a class is at least tutored by all the teachers
 * assigned to that class. */
pred inv14_OK {
	all s : Person, c : Class, t : Teacher, g : Group | (c -> s -> g in Groups) and t in c.Teaches implies s in t.Tutors 
}
/* The tutoring chain of every person eventually reaches a Teacher. */
pred inv15_OK {
	all s : Student | some t : Teacher | t in s.^Tutors
}

/* Repairing inv7 */
pred inv7 {
	all c:Class | some t:Teacher | t in c.Teaches
}

assert repaired_inv7 {
	inv7[] iff inv7_OK[]
}

/* Checking all invariants*/
pred checkAll {
	inv1_OK && inv2_OK && inv3_OK && inv4_OK && inv5_OK && inv6_OK && repaired_inv7 && inv8_OK && inv9_OK && inv10_OK && inv11_OK && inv12_OK && inv13_OK && inv14_OK && inv15_OK
}

check checkAll expect 0

/* Output:
   pred checkAll {
  inv1_OK && inv2_OK && inv3_OK && inv4_OK && inv5_OK && inv6_OK && inv7 && inv8_OK && inv9_OK && inv10_OK && inv11_OK && inv12_OK && inv13_OK && inv14_OK && inv15_OK
}
   All predicates are satisfied.