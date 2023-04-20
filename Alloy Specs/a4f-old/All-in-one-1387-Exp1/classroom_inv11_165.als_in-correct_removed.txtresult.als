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
    Teachers: set Teacher
}

/* Some persons are teachers. */
sig Teacher extends Person {}

/* Some persons are students. */
sig Student extends Person {}

/* Every person is a student. */
pred inv1 {
    Person in Student
}

/* No teacher is a student. */
pred inv2 {
    Teacher not in Student
}

/* No person is both a student and a teacher. */
pred inv3 {
    no Student & Teacher
}

/* Every person is either a student or a teacher. */
pred inv4 {
    Person in Student + Teacher
}

/* Every class has at least one teacher assigned. */
pred inv5 {
    all c: Class | c.Teachers != none
}

/* Every teacher teaches at least one class. */
pred inv6 {
    all t: Teacher | t.Teaches != none
}

/* Every class in the system is currently being taught. */
pred inv7 {
    all c: Class | some t: Teacher | t teaches c
}

/* For each class, every group is assigned at least one student. */
pred inv8 {
    all c: Class | all g: c.Groups | some s: Student | s in dom[c.Groups[g]]
}

/* Every teacher is assigned to a non-empty set of groups across all their classes. */
pred inv9 {
    all t: Teacher | some g: Group | g in (t.Teaches.(Class.Groups))
}

/* A student is not their own teacher. */
pred inv10 {
    no s: Student | s in s.Tutors
}

/* A class only has groups if it has a teacher assigned. */
pred inv11 {
    all c : Class | (some c.Groups) implies some c.Teachers
}

/* Each teacher is assigned to at most one class. */
pred inv12 {
    all t : Teacher | lone t.Teaches
}

/* Only teachers tutor, and only students are tutored. */
pred inv13 {
    Tutors.Person in Teacher and Person.Tutors in Student
}

/* Every student in a class is at least tutored by all the teachers assigned to that class. */
pred inv14 {
    all c: Class | all s: Student | s in dom[c.Groups] implies all t: c.Teachers | s in t.Tutors
}

/* The tutoring chain of every person eventually reaches a Teacher. */
pred inv15 {
    all s : Student | some t : Teacher | s in t.^Tutors
}

/*=================== IFF PERFECT ORACLE ===============*/

pred inv1_OK {
    Person in Student
}
assert inv1_Repaired {
    inv1[] iff inv1_OK[]
}

pred inv2_OK {
    no Teacher & Student
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
    Person in Student + Teacher
}
assert inv4_Repaired {
    inv4[] iff inv4_OK[]
}

pred inv5_OK {
    some c: Class | some t: Teacher | t teaches c
}
assert inv5_Repaired {
    inv5[] iff inv5_OK[]
}

pred inv6_OK {
    some t: Teacher | some c: Class | t teaches c
}
assert inv6_Repaired {
    inv6[] iff inv6_OK[]
}

pred inv7_OK {
    all c: Class | all g: c.Groups | some s: Student | s in dom[c.Groups[g]]
}
assert inv7_Repaired {
    inv7[] iff inv7_OK[]
}

pred inv8_OK {
    all t: Teacher | some g: Group | g in (t.Teaches.(Class.Groups))
}
assert inv8_Repaired {
    inv8[] iff inv8_OK[]
}

pred inv9_OK {
    no s: Student | s in s.Tutors
}
assert inv9_Repaired {
    inv9[] iff inv9_OK[]
}

pred inv10_OK {
    all c : Class | (some c.Groups) implies some c.Teachers
}
assert inv10_Repaired {
    inv10[] iff inv10_OK[]
}

pred inv11_OK {
    all t : Teacher | lone t.Teaches
}
assert inv11_Repaired {
    inv11[] iff inv11_OK[]
}

pred inv12_OK {
    Tutors.Person in Teacher and Person.Tutors in Student
}
assert inv12_Repaired {
    inv12[] iff inv12_OK[]
}

pred inv13_OK {
    all c: Class | all s: Student | s in dom[c.Groups] implies all t: c.Teachers | s in t.Tutors
}
assert inv13_Repaired {
    inv13[] iff inv13_OK[]
}

pred inv14_OK {
    all s : Student | some t : Teacher | s in t.^Tutors
}
assert inv14_Repaired {
    inv14[] iff inv14_OK[]
}

pred inv15_OK {
    all s: Student | s in s.^Tutors.Teacher
}
assert inv15_Repaired {
    inv15[] iff inv15_OK[]
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
check inv15_Repaired expect 0

pred repair_pred_1 { inv11[] iff inv11_OK[] }
run repair_pred_1
assert repair_assert_1 { inv11[] iff inv11_OK[] }
check repair_assert_1