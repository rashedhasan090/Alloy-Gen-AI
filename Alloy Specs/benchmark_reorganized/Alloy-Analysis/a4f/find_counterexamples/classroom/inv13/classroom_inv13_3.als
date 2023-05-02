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
sig Teacher in Person {}
/* Some persons are students. */
sig Student in Person {}
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
	all t: Teacher | t.Teaches != none
}
/* Every class has teachers assigned. */
pred inv7 {
	all c: Class | c.Teaches != none
}
/* Teachers are assigned at most one class. */
pred inv8 {
	all t:Teacher | lone t.Teaches
}
/* No class has more than a teacher assigned. */
pred inv9 {
	all c: Class | lone c.Teaches.Teacher
}
/* For every class, every student has a group assigned. */
pred inv10 {
	all c: Class, s: Student | some s.(c.Groups)
}
/* A class only has groups if it has a teacher assigned. */
pred inv11 {
	all c: Class | (some c.Groups) implies some t: Teacher | t.Teaches = c
}
/* Each teacher is responsible for some groups. */
pred inv12 {
	all t: Teacher | some g: Group | g in (t.Teaches.Groups).Person.Tutors
}
/* Only teachers tutor, and only students are tutored. */
pred inv13 {
	all t: Teacher, s: Student | s not in t.^Tutors 
}
/* Every student in a class is at least tutored by all the teachers
 * assigned to that class. */
pred inv14 {
	all c: Class, s: Student | s in c.Groups.Person.Tutors implies s in c.Teaches.Teacher.Tutors
}
/* The tutoring chain of every person eventually reaches a Teacher. */
pred inv15 {
	all s : Person | some t: Teacher | s in t.^Tutors
}

/*================== REPAIRS ==================*/
/*Replacing inv13*/
pred inv13_fix{
  all t:Teacher | all s:Student -- t | s not in t.^Tutors
}

assert TutoringSystem_correct {
  inv1 && inv2 && inv3 && inv4 && inv5 && inv6 && inv7 && inv8 && inv9 && inv10 && inv11 && inv12 && inv13_fix && inv14 && inv15
}

check TutoringSystem_correct for 5 but 4 Teacher, 5 Student, 4 Group, 5 Class
run TutoringSystem_correct for 5 but 4 Teacher, 5 Student, 4 Group, 5 Class

/*Iff Perfect Oracle*/
pred inv13_ok{
	all t:Teacher, s:Student|s not in t.^Tutors
}

assert TutoringSystem_perfect {
	inv1 && inv2 && inv3 && inv4 && inv5 && inv6 && inv7 && inv8 && inv9 && inv10 && inv11 && inv12 && inv13_ok && inv14 && inv15
}

pred repair_pred_1{
   inv13[] iff inv13_ok[]
}

run repair_pred_1
assert repair_assert_1{
   inv13[] iff inv13_ok[]
}
check repair_assert_1