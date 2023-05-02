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
	Person in Student ----correct
}
/* There are no teachers. */
pred inv2 {
	no Teacher ----correct
}
/* No person is both a student and a teacher. */
pred inv3 {
	no Student & Teacher ----correct
}
/* No person is neither a student nor a teacher. */
pred inv4 {
	Person in (Student + Teacher) ----correct
}
/* There are some classes assigned to teachers. */
pred inv5 {
	some Teacher.Teaches ----correct
}
/* Every teacher has classes assigned. */
pred inv6 {
	Teacher.Teaches = Class ----fixed
}
/* Every class has teachers assigned. */
pred inv7 {
	Class in Teacher.Teaches ----correct
}
/* Teachers are assigned at most one class. */
pred inv8 {
	all t : Teacher | lone t.Teaches ----correct
}
/* No class has more than a teacher assigned. */
pred inv9 {
	no disj c1, c2 : Class | c1.Teacher = c2.Teacher and c1 != c2 ----fixed
}
/* For every class, every student has a group assigned. */
pred inv10 {
	all c : Class, s : Student | some c.Groups.s ----correct
}
/* A class only has groups if it has a teacher assigned. */
pred inv11 {
	all c : Class | (some c.Groups) implies some (Teaches.c & Teacher) ----correct
}
/* Each teacher is responsible for some groups. */
pred inv12 {
	all t : Teacher | some (t.Teaches).Groups ----correct
}
/* Only teachers tutor, and only students are tutored. */
pred inv13 {
	Tutors.Person in Teacher and Person.Tutors in Student ----correct
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

/*=========Fixed or Reconstructed asserts=============*/
pred inv5_recon {
    some t: Teacher | t.Teaches != none
}

assert inv5_fixed{
    inv5[] iff inv5_recon[]
}

pred inv9_recon{
    all t: Teacher, c1, c2: Class | t -> c1 in Teaches and t -> c2 in Teaches and c1 != c2 implies no disj s1, s2: Student | s1 -> c1 -> _ in Groups and s2 -> c2 -> _ in Groups and s1 <> s2 
}

assert inv9_fixed{
    inv9[] iff inv9_recon[]
}

// Perfact oracle commands
check inv1 expect 0
check inv2 expect 0
check inv3 expect 0
check inv4 expect 0
check inv5_fixed expect 0
check inv6 expect 0
check inv7 expect 0
check inv8 expect 0
check inv9_fixed expect 0
check inv10 expect 0
check inv11 expect 0
check inv12 expect 0
check inv13 expect 0
check inv14 expect 0
check inv15 expect 0