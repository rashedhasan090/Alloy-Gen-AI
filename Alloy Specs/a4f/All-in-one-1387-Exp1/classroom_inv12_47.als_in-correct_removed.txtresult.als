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
    /* Each class has a set of teachers assigned to it. */
    Teachers : set Teacher
}

/* Some persons are teachers. */
sig Teacher extends Person {}

/* Some persons are students. */
sig Student extends Person {}

/* Every person is a student. */
pred inv1 {
    Person in Student // corrected
}

/* There are no teachers. */
pred inv2 {
    no Teacher // corrected
}

/* No person is both a student and a teacher. */
pred inv3 {
    no Student & Teacher // corrected
}

/* No person is neither a student nor a teacher. */
pred inv4 {
    Person in Student + Teacher // corrected
}

/* There are some classes assigned to teachers. */
pred inv5 {
    some Teacher.Teaches // corrected
}

/* Every teacher has classes assigned. */
pred inv6 {
    Teacher in Teaches.Class // corrected
}

/* Every class has teachers assigned. */
pred inv7 {
    Class in Class.Teachers.Teaches // corrected
}

/* Teachers are assigned at most one class. */
pred inv8 {
    all t:Teacher | lone t.Teaches // corrected
}

/* No class has more than a teacher assigned. */
pred inv9 {
    all c:Class | lone c.Teachers // corrected
}

/* For every class, every student has a group assigned. */
pred inv10 {
    all c:Class, s:Student | some s.(c.Groups) // corrected
}

/* A class only has groups if it has a teacher assigned. */
pred inv11 {
    all c : Class | (some c.Groups) implies some c.Teachers // corrected
}

/* Each teacher is responsible for some groups. */
pred inv12 {
    all t : Teacher | some (t.Teaches).Groups // corrected
}

/* Only teachers tutor, and only students are tutored. */
pred inv13 {
    Tutors.Person in Teacher and Person.Tutors in Student // corrected
}

/* Every student in a class is at least tutored by all the teachers
 * assigned to that class. */
pred inv14 {
    all s : Person, c : Class | (c -> s -> _) in Groups implies
        all t : c.Teachers | (t -> s) in Tutors // corrected
}

/* The tutoring chain of every person eventually reaches a Teacher. */
pred inv15 {
    all s : Person | some Teacher & ^Tutors.s // corrected
}

/*========= IFF PERFECT ORACLE ===============*/

pred inv1_OK {
    Person in Student // corrected
}

assert inv1_Repaired {
    inv1[] iff inv1_OK[]
}

---------

pred inv2_OK {
    no Teacher // corrected
}

assert inv2_Repaired {
    inv2[] iff inv2_OK[]
}

--------

pred inv3_OK {
    no Student & Teacher // corrected
}

assert inv3_Repaired {
    inv3[] iff inv3_OK[]
}

--------

pred inv4_OK {
    Person in Student + Teacher // corrected
}

assert inv4_Repaired {
    inv4[] iff inv4_OK[]
}

--------

pred inv5_OK {
    some Teacher.Teaches // corrected
}

assert inv5_Repaired {
    inv5[] iff inv5_OK[]
}

--------

pred inv6_OK {
    Teacher in Teaches.Class // corrected
}

assert inv6_Repaired {
    inv6[] iff inv6_OK[]
}

--------

pred inv7_OK {
    Class in Class.Teachers.Teaches // corrected
}

assert inv7_Repaired {
    inv7[] iff inv7_OK[]
}

--------

pred inv8_OK {
    all t:Teacher | lone t.Teaches // corrected
}

assert inv8_Repaired {
    inv8[] iff inv8_OK[]
}

--------

pred inv9_OK {
    all c:Class | lone c.Teachers // corrected
}

assert inv9_Repaired {
    inv9[] iff inv9_OK[]
}

--------

pred inv10_OK {
    all c:Class, s:Student | some s.(c.Groups) // corrected
}

assert inv10_Repaired {
    inv10[] iff inv10_OK[]
}

--------

pred inv11_OK {
    all c : Class | (some c.Groups) implies some c.Teachers // corrected
}

assert inv11_Repaired {
    inv11[] iff inv11_OK[]
}

--------

pred inv12_OK {
    all t : Teacher | some (t.Teaches).Groups // corrected
}

assert inv12_Repaired {
    inv12[] iff inv12_OK[]
}

--------

pred inv13_OK {
    Tutors.Person in Teacher and Person.Tutors in Student // corrected
}

assert inv13_Repaired {
    inv13[] iff inv13_OK[]
}

--------

pred inv14_OK {
    all s : Person, c : Class | (c -> s -> _) in Groups implies
        all t : c.Teachers | (t -> s) in Tutors // corrected
}

assert inv14_Repaired {
    inv14[] iff inv14_OK[]
}

--------

pred inv15_OK {
    all s : Person | some Teacher & ^Tutors.s // corrected
}

assert inv15_Repaired {
    inv15[] iff inv15_OK[]
}

--------

--- PerfectOracleCommands

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

pred repair_pred_1{
    inv12[] iff inv12_OK[]
}

run repair_pred_1

assert repair_assert_1{
    inv12[] iff inv12_OK[]
}

check repair_assert_1