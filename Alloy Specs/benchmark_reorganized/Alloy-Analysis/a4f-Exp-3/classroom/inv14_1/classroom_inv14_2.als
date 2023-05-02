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
    some c: Class | some t: Teacher | t.Teaches = c
}
/* Every teacher has classes assigned. */
pred inv6 {
    all t: Teacher | some c: Class | t.Teaches = c
}
/* Every class has teachers assigned. */
pred inv7 {
    all c: Class | some t: Teacher | t.Teaches = c
}
/* Teachers are assigned at most one class. */
pred inv8 {
    all t: Teacher | lone t.Teaches
}
/* No class has more than one teacher assigned. */
pred inv9 {
    all c: Class | lone t: Teacher | t.Teaches = c
}
/* For every class, every student has a group assigned. */
pred inv10 {
    all c: Class, s: Student | c.Groups[s] != none
}
/* A class only has groups if it has a teacher assigned. */
pred inv11 {
    all c: Class | c.Groups != none implies some t: Teacher | t.Teaches = c
}
/* Each teacher is responsible for some groups. */
pred inv12 {
    all t: Teacher | some c: Class | t.Teaches = c && c.Groups[t] != none
}
/* Only teachers tutor, and only students are tutored. */
pred inv13 {
    all t: Teacher, s: Student | s.Tutors = t && t.Teaches in s.Tutors
}
/* Every student in a class is at least tutored by all the teachers
 * assigned to that class. */
pred inv14 {
    all c: Class, s: Student | s in c.Groups.Person.Tutors => s in c.Teaches.Tutors
}
/* The tutoring chain of every person eventually reaches a Teacher. */
pred inv15 {
    all s: Student | some t: Teacher | t in s.^Tutors
}

/* ========= IFF PERFECT ORACLE =============== */
pred inv1_OK {
    Person in Student
}
assert inv1_Repaired {
    inv1[] iff inv1_OK[]
}
pred inv2_OK {
    no Teacher
}
assert inv2_Repaired {
    inv2[] iff inv2_OK[]
}
pred inv3_OK {
    no Student & Teacher
}
assert inv3_Repaired {
    inv3[] iff inv3_OK[]
}
pred inv4_OK {
    Person = Student + Teacher
}
assert inv4_Repaired {
    inv4[] iff inv4_OK[]
}
pred inv5_OK {
    some c: Class | some t: Teacher | t.Teaches = c
}
assert inv5_Repaired {
    inv5[] iff inv5_OK[]
}
pred inv6_OK {
    all t: Teacher | some c: Class | t.Teaches = c
}
assert inv6_Repaired {
    inv6[] iff inv6_OK[]
}
pred inv7_OK {
    all c: Class | some t: Teacher | t.Teaches = c
}
assert inv7_Repaired {
    inv7[] iff inv7_OK[]
}
pred inv8_OK {
    all t: Teacher | lone t.Teaches
}
assert inv8_Repaired {
    inv8[] iff inv8_OK[]
}
pred inv9_OK {
    all c: Class | lone t: Teacher | t.Teaches = c
}
assert inv9_Repaired {
    inv9[] iff inv9_OK[]
}
pred inv10_OK {
    all c: Class, s: Student | c.Groups[s] != none
}
assert inv10_Repaired {
    inv10[] iff inv10_OK[]
}
pred inv11_OK {
    all c: Class | c.Groups != none implies some t: Teacher | t.Teaches = c
}
assert inv11_Repaired {
    inv11[] iff inv11_OK[]
}
pred inv12_OK {
    all t: Teacher | some c: Class | t.Teaches = c && c.Groups[t] != none
}
assert inv12_Repaired {
    inv12[] iff inv12_OK[]
}
pred inv13_OK {
    all t: Teacher, s: Student | s.Tutors = t && t.Teaches in s.Tutors
}
assert inv13_Repaired {
    inv13[] iff inv13_OK[]
}
pred inv14_OK {
    all c: Class, s: Student | s in c.Groups.Person.Tutors => s in c.Teaches.Tutors
}
assert inv14_Repaired {
    inv14[] iff inv14_OK[]
}
pred inv15_OK {
    all s: Student | some t: Teacher | t in s.^Tutors
}
assert inv15_Repaired {
    inv15[] iff inv15_OK[]
}

/* ======== END OF REPAIRED SPECIFICATION ========= */

---- PerfectOracleCommands
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