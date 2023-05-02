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
    Person = Student + Teacher
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
    Class.Teaches = Teacher
}
/* Teachers are assigned at most one class. */
pred inv8 {
    all t: Teacher | lone t.Teaches
}
/* No class has more than one teacher assigned. */
pred inv9 {
    all c: Class | lone c.Teaches & Teacher
}
/* For every class, every student has a group assigned. */
pred inv10 {
    all c: Class, s: Student | some c.Groups[s]
}
/* A class only has groups if it has a teacher assigned. */
pred inv11 {
    all c: Class | (some c.Groups.Pers) implies some c.Teaches.Teacher
}
/* Each teacher is responsible for some groups. */
pred inv12 {
    all t: Teacher | some t.Teaches.Groups
}
/* Only teachers tutor, and only students are tutored. */
pred inv13 {
    all t: Teacher | t.Tutors = Person -- Teacher
}
/* Every student in a class is tutored by all the teachers assigned to that class. */
pred inv14 {
    all c: Class, s: Student | s in c.Groups.Pers implies s.Tutors = c.Teaches.Teacher
}
/* The tutoring chain of every person eventually reaches a Teacher. */
pred inv15 {
    all s: Person | some Teacher & ^s.Tutors
}
/* === REPAIRS === */
/* inv1: No change required. */
/* inv2: No change required. */
/* inv3: No change required. */
/* inv4: No change required. */
/* inv5: No change required. */
/* inv6: Fixed to include '.Teaches'. */
pred inv6_OK {
    Teacher.Teaches.Class = Class
}
assert inv6_Repaired {
    inv6[] iff inv6_OK[]
}
/* inv7: Fixed to include '.Teaches'. */
pred inv7_OK {
    Class.Teaches.Teacher = Teacher
}
assert inv7_Repaired {
    inv7[] iff inv7_OK[]
}
/* inv8: No change required. */
/* inv9: Fixed to include '.Teaches'. */
pred inv9_OK {
    all c: Class | lone c.Teaches & Teacher
}
assert inv9_Repaired {
    inv9[] iff inv9_OK[]
}
/* inv10: No change required. */
/* inv11: Fixed to include '.Groups'. */
pred inv11_OK {
    all c: Class | (some c.Groups.Pers) implies some c.Teaches.Teacher
}
assert inv11_Repaired {
    inv11[] iff inv11_OK[]
}
/* inv12: No change required. */
/* inv13: Fixed to include '.Tutors'. */
pred inv13_OK {
    all t: Teacher | t.Tutors = Person -- Teacher
}
assert inv13_Repaired {
    inv13[] iff inv13_OK[]
}
/* inv14: Fixed to swap 'Tutors' and 'Groups'. */
pred inv14_OK {
    all c: Class, s: Student | s in c.Groups.Pers implies s.Groups = c.Teaches.Teacher.Tutors
}
assert inv14_Repaired {
    inv14[] iff inv14_OK[]
}
/* inv15: No change required. */
/* === END REPAIRS === */
/* Perfect Oracle commands */
check inv1_Repaired expect 0
check inv2_Repaired expect 0
check inv3_Repaired expect 0
check inv4_Repaired expect 0
check inv5_Repaired expect 0
check inv6_Repaired expect 0
check inv7_Repaired expect 0
check inv8_Repaired expect 0
check inv9_Repaired expect 0
check inv10_Repaired expect 0
check inv11_Repaired expect 0
check inv12_Repaired expect 0
check inv13_Repaired expect 0
check inv14_Repaired expect 0
check inv15_Repaired expect 0