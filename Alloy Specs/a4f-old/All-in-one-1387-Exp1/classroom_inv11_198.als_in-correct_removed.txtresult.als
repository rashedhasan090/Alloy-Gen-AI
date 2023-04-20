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
    TaughtBy : set Teacher
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
    Person in Student + Teacher
}

/* There are some classes taught by teachers. */
pred inv5 {
    some c : Class | c.TaughtBy in Teacher
}

/* Every teacher has classes assigned. */
pred inv6 {
    all t : Teacher | some t.Teaches
}

/* Every class has teachers assigned. */
pred inv7 {
    all c : Class | some c.TaughtBy
}

/* Teachers are assigned at most one class. */
pred inv8 {
    all t : Teacher | lone t.Teaches
}

/* No class has more than a teacher assigned. */
pred inv9 {
    all c : Class | lone c.TaughtBy
}

/* For every class, every student has a group assigned. */
pred inv10 {
    all c : Class, s : Student | some c.Groups[s]
}

/* A class only has groups if it has a teacher assigned. */
pred inv11 {
    all c : Class | (some c.Groups) implies some c.TaughtBy
}

/* Each teacher is responsible for some groups. */
pred inv12 {
    all t : Teacher | some t.Teaches.(Groups)
}

/* Only teachers tutor, and only students are tutored. */
pred inv13 {
    all p : Person | ((p.Tutors in Teacher) iff (p in Student))
}

/* Every student in a class is at least tutored by all the teachers
 * assigned to that class. */
pred inv14 {
    all c : Class, s : Student | (some c.Groups[s]) implies (all t : c.TaughtBy | t in s.Tutors)
}

/* The tutoring chain of every person eventually reaches a Teacher. */
pred inv15 {
    all s : Person | some ^(s.Tutors & Teacher)
}

/* Perfect Oracle */
pred inv1_OK { inv1 }
assert inv1_Repaired { inv1[] iff inv1_OK[] }

pred inv2_OK { inv2 }
assert inv2_Repaired { inv2[] iff inv2_OK[] }

pred inv3_OK { inv3 }
assert inv3_Repaired { inv3[] iff inv3_OK[] }

pred inv4_OK { inv4 }
assert inv4_Repaired { inv4[] iff inv4_OK[] }

pred inv5_OK { inv5 }
assert inv5_Repaired { inv5[] iff inv5_OK[] }

pred inv6_OK { inv6 }
assert inv6_Repaired { inv6[] iff inv6_OK[] }

pred inv7_OK { inv7 }
assert inv7_Repaired { inv7[] iff inv7_OK[] }

pred inv8_OK { inv8 }
assert inv8_Repaired { inv8[] iff inv8_OK[] }

pred inv9_OK { inv9 }
assert inv9_Repaired { inv9[] iff inv9_OK[] }

pred inv10_OK { inv10 }
assert inv10_Repaired { inv10[] iff inv10_OK[] }

pred inv11_OK { inv11 }
assert inv11_Repaired { inv11[] iff inv11_OK[] }

pred inv12_OK { inv12 }
assert inv12_Repaired { inv12[] iff inv12_OK[] }

pred inv13_OK { inv13 }
assert inv13_Repaired { inv13[] iff inv13_OK[] }

pred inv14_OK { inv14 }
assert inv14_Repaired { inv14[] iff inv14_OK[] }

pred inv15_OK { inv15 }
assert inv15_Repaired { inv15[] iff inv15_OK[] }

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

run {}

assert repair_assert_1{inv11[] iff inv11_OK[] }
check repair_assert_1