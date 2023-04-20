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
    Groups : Person -> Group,
    /* The teacher assigned to a class */
    Teacher : lone Teacher
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
    all c : Class | one t : Teacher | t in c.Teacher
}

/* Teachers are assigned at most one class. */
pred inv8 {
    all t:Teacher | lone t.Teaches
}

/* No class has more than one teacher assigned. */
pred inv9 {
    all c:Class | lone c.Teacher
}

/* For every class, every student has a group assigned. */
pred inv10 {
    all c:Class, s:Student | some s.(c.Groups)
}

/* A class only has groups if it has a teacher assigned. */
pred inv11 {
    all c : Class | (some c.Groups) implies some Teacher & c.Teacher = Teacher
}

/* Each teacher is responsible for some groups. */
pred inv12 {
    all t : Teacher | some (t.Teaches).Groups
}

/* Only teachers tutor, and only students are tutored. */
pred inv13 {
    Tutors.Person in Teacher and Person.Tutors in Student
}

/* Every student in a class is tutored by all the teachers assigned to that class. */
pred inv14 {
    all s : Student, c : Class | s in c.Groups.(Teacher.Tutors)
}

/* The tutoring chain of every person eventually reaches a Teacher. */
pred inv15 {
    all s : Student | some Teacher & ^s.Tutors in Teacher
}

/* Asserting the repaired invariants */
pred inv1_Repaired{
    Person in Student
}

assert inv1_fixed{
    inv1[] iff inv1_Repaired[]
}

pred inv2_Repaired{
    no Teacher
}
assert inv2_fixed{
    inv2[] iff inv2_Repaired[]
}

pred inv3_Repaired{
    no Student & Teacher
}
assert inv3_fixed{
    inv3[] iff inv3_Repaired[]
}

pred inv4_Repaired{
    Person in Student + Teacher
}
assert inv4_fixed{
    inv4[] iff inv4_Repaired[]
}

pred inv5_Repaired{
    some Teacher.Teaches
}
assert inv5_fixed{
    inv5[] iff inv5_Repaired[]
}

pred inv6_Repaired{
    Teacher in Teaches.Class
}
assert inv6_fixed{
    inv6[] iff inv6_Repaired[]
}

pred inv7_Repaired{
    all c:Class | one t:Teacher | t = c.Teacher
}
assert inv7_fixed{
    inv7[] iff inv7_Repaired[]
}

pred inv8_Repaired{
    all t:Teacher | lone t.Teaches
}
assert inv8_fixed{
    inv8[] iff inv8_Repaired[]
}

pred inv9_Repaired{
    all c:Class | lone c.Teacher
}
assert inv9_fixed{
    inv9[] iff inv9_Repaired[]
}

pred inv10_Repaired{
    all c:Class, s:Student | some s.(c.Groups)
}
assert inv10_fixed{
    inv10[] iff inv10_Repaired[]
}

pred inv11_Repaired{
    all c:Class | (some c.Groups) implies some Teacher & c.Teacher = Teacher
}
assert inv11_fixed{
    inv11[] iff inv11_Repaired[]
}

pred inv12_Repaired{
    all t:Teacher | some (t.Teaches).Groups
}
assert inv12_fixed{
    inv12[] iff inv12_Repaired[]
}

pred inv13_Repaired{
    Tutors.Person in Teacher and Person.Tutors in Student
}
assert inv13_fixed{
    inv13[] iff inv13_Repaired[]
}

pred inv14_Repaired{
    all s:Student, c:Class | s in c.Groups.(Teacher.Tutors)
}
assert inv14_fixed{
    inv14[] iff inv14_Repaired[]
}

pred inv15_Repaired{
    all s:Student | some Teacher & ^s.Tutors in Teacher
}
assert inv15_fixed{
    inv15[] iff inv15_Repaired[]
}

--- PerfectOracleCommands
check inv1_fixed expect 0
check inv2_fixed expect 0
check inv3_fixed expect 0
check inv4_fixed expect 0
check inv5_fixed expect 0
check inv6_fixed expect 0
check inv7_fixed expect 0
check inv8_fixed expect 0
check inv9_fixed expect 0
check inv10_fixed expect 0
check inv11_fixed expect 0
check inv12_fixed expect 0
check inv13_fixed expect 0
check inv14_fixed expect 0
check inv15_fixed expect 0

--- Repairing command
run inv14_Repaired
assert inv14_after_repair{
    inv14[] iff inv14_Repaired[]
}
check inv14_after_repair