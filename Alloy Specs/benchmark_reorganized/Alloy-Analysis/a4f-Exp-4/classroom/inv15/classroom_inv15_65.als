/* The registered persons. */
sig Person {
  Tutors: set Person, 
  Teaches: set Class
}
/* The registered groups. */
sig Group {}
/* The registered classes. */
sig Class {
  Groups: Person -> set Group
}
/* Some persons are teachers. */
sig Teacher extends Person {}
/* Some persons are students. */
sig Student extends Person {}
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
  Person = Student + Teacher
}
/* There are some classes assigned to teachers. */
pred inv5 {
  some t: Teacher | t.Teaches != {}
}
/* Every teacher has classes assigned. */
pred inv6 {
  all t: Teacher | t.Teaches != none
}
/* Every class has teachers assigned. */
pred inv7 {
  all c: Class | c.Teachers != none
}
/* Teachers are assigned at most one class. */
pred inv8 {
  all t: Teacher | lone t.Teaches
}
/* No class has more than one teacher assigned. */
pred inv9 {
  all c: Class | lone t: Teacher | t in c.Teaches 
}
/* For every class, every student has a group assigned. */
pred inv10 {
  all c: Class, s: Student | some g: (c.Groups[s]) 
}
/* A class only has groups if it has a teacher assigned. */
pred inv11 {
  all c: Class | (some c.Teachers) implies (some t: Teacher | t.Teaches = c)
}
/* Each teacher is responsible for some groups. */
pred inv12 {
  all t: Teacher | some c: t.Teaches | some g: (c.Groups[t])
}
/* Only teachers tutor, and only students are tutored. */
pred inv13 {
  all t: Teacher | t.Tutors in Teacher
  all s: Student | s.Tutors in Student
}
/* Every student in a class is at least tutored by all the teachers
assigned to that class. */
pred inv14 {
  all c: Class, s: Student, t: Teacher | (t -> c in Teaches) and (c -> s in Groups) implies (s -> t in Tutors)
}
/* The tutoring chain of every person eventually reaches a Teacher. */
pred inv15 {
  all p: Person | some t: Teacher | p -> t in Tutors
}

/*=============================================*/

run inv1 for 3
run inv2 for 3
run inv3 for 3
run inv4 for 3
run inv5 for 3
run inv6 for 3
run inv7 for 3
run inv8 for 3
run inv9 for 3
run inv10 for 3
run inv11 for 3
run inv12 for 3
run inv13 for 3
run inv14 for 3
run inv15 for 3