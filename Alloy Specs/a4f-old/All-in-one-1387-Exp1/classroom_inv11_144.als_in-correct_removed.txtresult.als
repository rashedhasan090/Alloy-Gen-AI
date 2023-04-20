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
    /* Each class has a set of teachers. */
    ClassTeachers : set Person
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

/* Some classes have teachers assigned */
pred inv5 {
    some c : Class | c.ClassTeachers in Teacher.Teaches
}

/* Every teacher has classes assigned. */
pred inv6 {
    Teacher.Teaches = Class.ClassTeachers & Teacher
}

/* Every class has teachers assigned. */
pred inv7 {
    all c : Class | c.ClassTeachers in Teacher.Teaches
}

/* Teachers are assigned at most one class. */
pred inv8 {
    all t:Teacher | lone t.Teaches
}

/* No class has more than one teacher assigned. */
pred inv9 {
    all c:Class | lone c.ClassTeachers & Teacher
}

/* For every class, every student has a group assigned. */
pred inv10 {
    all c : Class | all s : Student | some c.Groups[s]
}

/* A class only has groups if it has a teacher assigned. */
pred inv11 {
    all c : Class | (some c.Groups) implies some c.ClassTeachers
}

/* Each teacher is responsible for some groups. */
pred inv12 {
    all t : Teacher | some (t.Teaches.Groups)
}

/* Only teachers tutor, and only students are tutored. */
pred inv13 {
    Tutors.Person in Teacher and Person.Tutors in Student
}

/* Every student in a class is at least tutored by all the teachers
 * assigned to that class. */
pred inv14 {
    all c : Class, s : Student | some c.Groups[s] implies all t : c.ClassTeachers | t -> s in Tutors
}

/* The tutoring chain of every person eventually reaches a Teacher. */
pred inv15 {
    all s : Student | some Teacher & ^s.Tutors
}

/*======== IFF PERFECT ORACLE ===============*/

/* Check if inv1 is repaired */
pred inv1_OK {
    Person in Student
}

assert inv1_Repaired {
    inv1[] iff inv1_OK[]
}

/* Check if inv2 is repaired */
pred inv2_OK {
    no Teacher
}

assert inv2_Repaired {
    inv2[] iff inv2_OK[]
}

/* Check if inv3 is repaired */
pred inv3_OK {
    no Student & Teacher
}

assert inv3_Repaired {
    inv3[] iff inv3_OK[]
}

/* Check if inv4 is repaired */
pred inv4_OK {
    Person in (Student + Teacher)
}

assert inv4_Repaired {
    inv4[] iff inv4_OK[]
}

/* Check if inv5 is repaired */
pred inv5_OK {
    some c : Class | c.ClassTeachers in Teacher.Teaches
}

assert inv5_Repaired {
    inv5[] iff inv5_OK[]
}

/* Check if inv6 is repaired */
pred inv6_OK {
    Teacher.Teaches = Class.ClassTeachers & Teacher
}

assert inv6_Repaired {
    inv6[] iff inv6_OK[]
}

/* Check if inv7 is repaired */
pred inv7_OK {
    all c : Class | c.ClassTeachers in Teacher.Teaches
}

assert inv7_Repaired {
    inv7[] iff inv7_OK[]
}

/* Check if inv8 is repaired */
pred inv8_OK {
    all t : Teacher | lone t.Teaches
}

assert inv8_Repaired {
    inv8[] iff inv8_OK[]
}

/* Check if inv9 is repaired */
pred inv9_OK {
    all c : Class | lone c.ClassTeachers & Teacher
}

assert inv9_Repaired {
    inv9[] iff inv9_OK[]
}

/* Check if inv10 is repaired */
pred inv10_OK {
    all c : Class | all s : Student | some c.Groups[s]
}

assert inv10_Repaired {
    inv10[] iff inv10_OK[]
}

/* Check if inv11 is repaired */
pred inv11_OK {
    all c : Class | (some c.Groups) implies some c.ClassTeachers
}

assert inv11_Repaired {
    inv11[] iff inv11_OK[]
}

/* Check if inv12 is repaired */
pred inv12_OK {
    all t : Teacher | some (t.Teaches.Groups)
}

assert inv12_Repaired {
    inv12[] iff inv12_OK[]
}

/* Check if inv13 is repaired */
pred inv13_OK {
    Tutors.Person in Teacher and Person.Tutors in Student
}

assert inv13_Repaired {
    inv13[] iff inv13_OK[]
}

/* Check if inv14 is repaired */
pred inv14_OK {
    all c : Class, s : Student | some c.Groups[s] implies all t : c.ClassTeachers | t -> s in Tutors
}

assert inv14_Repaired {
    inv14[] iff inv14_OK[]
}

/* Check if inv15 is repaired */
pred inv15_OK {
    all s : Student | some Teacher & ^s.Tutors
}

assert inv15_Repaired {
    inv15[] iff inv15_OK[]
}

-- PerfectOracleCommands
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

pred repair_pred_1 {
    inv11[] iff inv11_OK[]
}

run repair_pred_1

assert repair_assert_1 {
    inv11[] iff inv11_OK[]
}

check repair_assert_1