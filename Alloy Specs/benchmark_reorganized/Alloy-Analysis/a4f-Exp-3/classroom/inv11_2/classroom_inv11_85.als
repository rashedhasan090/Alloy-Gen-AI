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
	all c:Class | lone (Teaches.c & Teacher) 
}
/* For every class, every student has a group assigned. */
pred inv10 {
	all c:Class, s:Student | some s.(c.Groups) 
}
/* A class only has groups if it has a teacher assigned. */
pred inv11 {
	all c:Class | lone c.Groups implies (some Teaches.c & Teacher) 
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

/* The repaired assertions */

pred inv1_repaired {
	Person in Student
}

assert inv1_repaired_is_true {
	inv1_repaired
}

pred inv2_repaired {
	no Teacher
}

assert inv2_repaired_is_true {
	inv2_repaired
}

pred inv3_repaired {
	no (Student & Teacher)
}

assert inv3_repaired_is_true {
	inv3_repaired
}

pred inv4_repaired {
	Person in Student + Teacher
}

assert inv4_repaired_is_true {
	inv4_repaired
}

pred inv5_repaired {
	some t: Teacher | some t.Teaches
}

assert inv5_repaired_is_true {
	inv5_repaired
}

pred inv6_repaired {
	Teacher in Teaches.Class
}

assert inv6_repaired_is_true {
	inv6_repaired
}

pred inv7_repaired {
	Class in Teacher.Teaches
}

assert inv7_repaired_is_true {
	inv7_repaired
}

pred inv8_repaired {
	all t:Teacher | lone t.Teaches
}

assert inv8_repaired_is_true {
	inv8_repaired
}

pred inv9_repaired {
	all c:Class | lone [t: Teacher | t.Teaches = c].Teacher
}

assert inv9_repaired_is_true {
	inv9_repaired
}

pred inv10_repaired {
	all c: Class, s: Student | some g: (c.Person -> Group) | s in g.Persons
}

assert inv10_repaired_is_true {
	inv10_repaired
}

pred inv11_repaired {
	all c: Class | (no c.Groups) => (no Teaches.c & Teacher)
}

assert inv11_repaired_is_true {
	inv11_repaired
}

pred inv12_repaired {
      all t: Teacher | some c: Class | t.Teaches = c.Teaches && some g: (c.Person -> Group) | g.Persons = t.Tutors
}

assert inv12_repaired_is_true {
	inv12_repaired
}

pred inv13_repaired {
      Teacher = Tutors.Person && Student = Person.Tutors
}

assert inv13_repaired_is_true {
	inv13_repaired
}

pred inv14_repaired {
      all c: Class, s: Student | all t: Teacher | no (c -> s -> g in Groups) && t -> c in Teaches || t -> s in Tutors
}

assert inv14_repaired_is_true {
	inv14_repaired
}

pred inv15_repaired {
      all s: Person | some t: Teacher | t in ^Tutors.s
}

assert inv15_repaired_is_true {
	inv15_repaired
} 

/* The test assert with the repaired assertions */

assert test {
	inv1_repaired_is_true
	inv2_repaired_is_true
	inv3_repaired_is_true
	inv4_repaired_is_true
	inv5_repaired_is_true
	inv6_repaired_is_true
	inv7_repaired_is_true
	inv8_repaired_is_true
	inv9_repaired_is_true
	inv10_repaired_is_true
	inv11_repaired_is_true
	inv12_repaired_is_true
	inv13_repaired_is_true
	inv14_repaired_is_true
	inv15_repaired_is_true
}

check test
