Fixed code:

/* The registered persons. */
sig Person {
  /* Each person tutors a set of persons. */
  Tutors: set Person,
  /* Each person teaches a set of classes. */
  Teaches: set Class
}
/* The registered groups. */
sig Group {}
/* The registered classes. */
sig Class {
  /* Each class has a set of persons assigned to a group. */
  Groups: Person -> Group
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
  all c: Class | some t: Teacher | t.Teaches = c
}
/* Teachers are assigned at most one class. */
pred inv8 {
  all t: Teacher | lone t.Teaches
}
/* No class has more than a teacher assigned. */
pred inv9 {
  all c: Class | #Teaches.c <= 1
}
/* For every class, every student has a group assigned. */
pred inv10 {
  all c: Class, s: Student | some g: Group | (s, g) in c.Groups
}
/* A class only has groups if it has a teacher assigned. */
pred inv11 {
  all c: Class | (some c.Groups) implies some t: Teacher | t.Teaches = c
}
/* Each teacher is responsible for some groups. */
pred inv12 {
  all t: Teacher | some g: Group | (t, g) in ((t.Teaches).Groups)
}
/* Only teachers tutor, and only students are tutored. */
pred inv13 {
  all t : Teacher, s : Student | s in t.Tutors
}
/* Every student in a class is at least tutored by all the teachers
 * assigned to that class. */
pred inv14 {
  all c: Class, s: Student | let t = c.Teaches | s.Tutors >= t.tutors
}
/* The tutoring chain of every person eventually reaches a Teacher. */
pred inv15 {
  all p: Person | some t: Teacher | p in t.^Tutors
}

run inv1 + inv2 + inv3 + inv4 + inv5 + inv6 + inv7 + inv8 + inv9 + inv10 + inv11 + inv12 + inv13 + inv14 + inv15 for 5 Ciudades, 2 Clases, 3 Personas, 2 Grupos, 1 Tutors, 1 Teacher, 1 Student

/*
inv1_Repaired:
Person in Student
inv2_Repaired:
no Teacher
inv3_Repaired:
no Student & Teacher
inv4_Repaired:
Person in (Student + Teacher)
inv5_Repaired:
some Teacher.Teaches
inv6_Repaired:
Teacher in Teaches
inv7_Repaired:
all c : Class | some t : Teacher | t.Teaches = c
inv8_Repaired:
all t : Teacher | lone t.Teaches
inv9_Repaired:
all c : Class | #Teaches.c <= 1
inv10_Repaired:
all c : Class, s : Student | some g : Group | (s, g) in c.Groups
inv11_Repaired:
all c : Class | (some c.Groups) implies some t : Teacher | t.Teaches = c
inv12_Repaired:
all t : Teacher | some g : Group | (t, g) in t.Teaches.Groups
inv13_Repaired:
all s : Student, t : Teacher | s in t.Tutors
inv14_Repaired:
all c : Class, s : Student | let t = c.Teaches | s.Tutors >= t.tutors
inv15_Repaired:
all p : Person | some t : Teacher | p in t.^Tutors
*/
