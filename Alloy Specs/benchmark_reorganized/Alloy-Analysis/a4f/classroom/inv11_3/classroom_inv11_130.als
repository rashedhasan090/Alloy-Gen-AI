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
    Person in Student  ----correct
}
/* There are no teachers. */
pred inv2 {
    no Teacher  ----correct
}
/* No person is both a student and a teacher. */
pred inv3 {
    no Student & Teacher  ----correct
}
/* No person is neither a student nor a teacher. */
pred inv4 {
    Person in (Student + Teacher)  ----correct
}
/* There are some classes assigned to teachers. */
pred inv5 {
    some Teacher.Teaches  ----correct
}
/* Every teacher has classes assigned. */
pred inv6 {
    Teacher in Teaches ----Class  
}
/* Every class has teachers assigned. */
pred inv7 {
    Teacher in Class.Teaches ----correct
}
/* Teachers are assigned at most one class. */
pred inv8 {
    all t: Teacher | lone t.Teaches  ----correct
}
/* No class has more than a teacher assigned. */
pred inv9 {
    all c: Class | lone t: Teacher | t -> c in Teaches   ----correct
}
/* For every class, every student has a group assigned. */
pred inv10 {
    all c: Class, s: Student | some g: Group | c -> s -> g in Groups  ----correct
}
/* A class only has groups if it has a teacher assigned. */
pred inv11 {
    all c : Class | (some c.Groups) implies some t: Teacher | t -> c in Teaches  ----correct
}
/* Each teacher is responsible for some groups. */
pred inv12 {
    all t: Teacher | some c: t.Teaches | some g: Group | c -> g in Groups   ----correct
}
/* Only teachers tutor, and only students are tutored. */
pred inv13 {
    Tutors.Person in Teacher and Student in Tutors ----correct
}
/* Every student in a class is at least tutored by all the teachers
 * assigned to that class. */
pred inv14 {
    all c: Class, s: Student | some t: c.Teaches | t -> s in Tutors  ----correct
}
/* The tutoring chain of every person eventually reaches a Teacher. */
pred inv15 {
    all s: Student | some t: Teacher | s in t.^Tutors  ----correct
}

/*===========================*/
/* Repaired invariant asserts */
/*===========================*/

pred inv11_OK {
    all c: Class | (some c.Groups) implies some t: Teacher | t -> c in Teaches ----corrected
}

pred inv11_Repaired {
    inv11[] iff inv11_OK[]
}

assert inv11_assert_Repaired {
    inv11_Repaired
}

pred repair_inv11 {
    inv11_Repaired
}

run repair_inv11 for 1

/*===========================*/
/* Original invariant asserts */
/*===========================*/

assert inv1_assert {
    inv1
}
assert inv2_assert {
    inv2
}
assert inv3_assert {
    inv3
}
assert inv4_assert {
    inv4
}
assert inv5_assert {
    inv5
}
assert inv6_assert {
    inv6
}
assert inv7_assert {
    inv7
}
assert inv8_assert {
    inv8
}
assert inv9_assert {
    inv9
}
assert inv10_assert {
    inv10
}
assert inv11_assert {
    inv11
}
assert inv12_assert {
    inv12
}
assert inv13_assert {
    inv13
}
assert inv14_assert {
    inv14
}
assert inv15_assert {
    inv15
}

/*===============================*/
/* Perfect Oracle Checking Asserts */
/*===============================*/

assert inv1_PerfectOracle {
    inv1_Repaired iff inv1
}
assert inv2_PerfectOracle {
    inv2_Repaired iff inv2
}
assert inv3_PerfectOracle {
    inv3_Repaired iff inv3
}
assert inv4_PerfectOracle {
    inv4_Repaired iff inv4
}
assert inv5_PerfectOracle {
    inv5_Repaired iff inv5
}
assert inv6_PerfectOracle {
    inv6_Repaired iff inv6
}
assert inv7_PerfectOracle {
    inv7_Repaired iff inv7
}
assert inv8_PerfectOracle {
    inv8_Repaired iff inv8
}
assert inv9_PerfectOracle {
    inv9_Repaired iff inv9
}
assert inv10_PerfectOracle {
    inv10_Repaired iff inv10
}
assert inv11_PerfectOracle {
    inv11_Repaired iff inv11
}
assert inv12_PerfectOracle {
    inv12_Repaired iff inv12
}
assert inv13_PerfectOracle {
    inv13_Repaired iff inv13
}
assert inv14_PerfectOracle {
    inv14_Repaired iff inv14
}
assert inv15_PerfectOracle {
    inv15_Repaired iff inv15
}

/*=====================================*/
/* perfect oracle command check Assert */
/*=====================================*/

check inv1_PerfectOracle for 0
check inv2_PerfectOracle for 0
check inv3_PerfectOracle for 0
check inv4_PerfectOracle for 0
check inv5_PerfectOracle for 0
check inv6_PerfectOracle for 0
check inv7_PerfectOracle for 0
check inv8_PerfectOracle for 0
check inv9_PerfectOracle for 0
check inv10_PerfectOracle for 0
check inv11_PerfectOracle for 0
check inv12_PerfectOracle for 0
check inv13_PerfectOracle for 0
check inv14_PerfectOracle for 0
check inv15_PerfectOracle for 0