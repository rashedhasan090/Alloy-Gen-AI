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
    /* Some classes are taught by teachers. */
    TaughtBy : set Teacher,
}

/* Some persons are teachers. */
sig Teacher extends Person  {}

/* Some persons are students. */
sig Student extends Person  {}

/* Every person is either a student or a teacher. */
pred inv1 {
    Person in (Student + Teacher)
}

/* There are no teachers or students. */
pred inv2 {
    no Teacher | no Student
}

/* No person is both a student and a teacher. */
pred inv3 {
    no Student & Teacher
}

/* No person is neither a student nor a teacher. */
pred inv4 {
    Person in (Student + Teacher)
}

/* Some classes are taught by teachers. */
pred inv5 {
    some c:Class | c.TaughtBy != none
}

/* Every class has a teacher assigned. */
pred inv6 {
    all c:Class | c.TaughtBy != none
}

/* Every teacher has at most one class assigned. */
pred inv7 {
    all t:Teacher | lone t.Teaches
}

/* No class has more than one teacher assigned. */
pred inv8 {
    all c:Class | lone c.TaughtBy
}

/* Every student in a class is assigned to a group. */
pred inv9 {
    all c:Class, s:Student | some c.Groups[s]
}

/* A class only has groups if it has a teacher assigned. */
pred inv10 {
    all c:Class | (some c.Groups) implies some c.TaughtBy
}

/* Each teacher is responsible for some groups in each class they teach. */
pred inv11 {
    all c:Class, t:Teacher | t.Teaches[c] implies some t.Tutors[c.Groups]
}

/* Only teachers tutor, and only students are tutored. */
pred inv12 {
    Tutors in Teacher and Student in Tutors.Person
}

/* Every student in a class is tutored by all the teachers assigned to that class. */
pred inv13 {
    all c:Class, s:Student | all t:c.TaughtBy | t.Tutors[s]
}

/* The tutoring chain of every person eventually reaches a Teacher. */
pred inv14 {
    all s:Person | some Teacher & ^s.Tutors
}

/* IFF PERFECT ORACLE */
pred inv1_OK {
    Person in Student
}

assert inv1_Repaired {
    inv1[] iff inv1_OK[]
}

pred inv2_OK {
    no Teacher and no Student
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
    Person in (Student + Teacher)
}

assert inv4_Repaired {
    inv4[] iff inv4_OK[]
}

pred inv5_OK {
    some c:Class | c.TaughtBy != none
}

assert inv5_Repaired {
    inv5[] iff inv5_OK[]
}

pred inv6_OK {
    all c:Class | c.TaughtBy != none
}

assert inv6_Repaired {
    inv6[] iff inv6_OK[]
}

pred inv7_OK {
    all t:Teacher | lone t.Teaches
}

assert inv7_Repaired {
    inv7[] iff inv7_OK[]
}

pred inv8_OK {
    all c:Class | lone c.TaughtBy
}

assert inv8_Repaired {
    inv8[] iff inv8_OK[]
}

pred inv9_OK {
    all c:Class, s:Student | some c.Groups[s]
}

assert inv9_Repaired {
    inv9[] iff inv9_OK[]
}

pred inv10_OK {
    all c:Class | (some c.Groups) implies some c.TaughtBy
}

assert inv10_Repaired {
    inv10[] iff inv10_OK[]
}

pred inv11_OK {
    all c:Class, t:Teacher | t.Teaches[c] implies some t.Tutors[c.Groups]
}

assert inv11_Repaired {
    inv11[] iff inv11_OK[]
}

pred inv12_OK {
    Tutors in Teacher and Student in Tutors.Person
}

assert inv12_Repaired {
    inv12[] iff inv12_OK[]
}

pred inv13_OK {
    all c:Class, s:Student | all t:c.TaughtBy | t.Tutors[s]
}

assert inv13_Repaired {
    inv13[] iff inv13_OK[]
}

pred inv14_OK {
    all s:Person | some Teacher & ^s.Tutors
}

assert inv14_Repaired {
    inv14[] iff inv14_OK[]
}

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

pred repair_pred_1{
    inv15[] iff inv14_OK[]
}
run repair_pred_1

assert repair_assert_1{
    inv15[] iff inv14_OK[]
}
check repair_assert_1