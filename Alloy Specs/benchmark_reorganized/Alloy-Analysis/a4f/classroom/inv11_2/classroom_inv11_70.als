/* The registered persons. */
sig Person {
    /* Each person tutors a set of persons. */
    Tutors : set Person,
    /* Each person teaches a set of classes. */
    Teaches : set Class
}
/* The registered groups. */
sig Group {}
/* The registered classes. */
sig Class {
    /* Each class has a set of persons assigned to a group. */
    Groups : Person -> Group
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
    Teacher.Teaches = Class and Teacher in Teacher.Teaches.Tutors
}
/* Every class has teachers assigned. */
pred inv7 {
    Teacher.Teaches = Class and Teacher in Class.Groups.Tutors
}
/* Teachers are assigned at most one class. */
pred inv8 {
    all t:Teacher | lone t.Teaches
}
/* No class has more than one teacher assigned. */
pred inv9 {
    all c:Class | lone Teacher & c.Teaches
}
/* For every class, every student has a group assigned. */
pred inv10 {
    all c:Class, s:Student | some c.Groups[s]
}
/* A class only has groups if it has a teacher assigned. */
pred inv11 {
    all c:Class | some c.Teaches && some t:Teacher | t.Teaches = c
}
/* Each teacher is responsible for some groups. */
pred inv12 {
    all t:Teacher | some t.Teaches.Groups
}
/* Only teachers tutor, and only students are tutored. */
pred inv13 {
    Teacher.Tutors = Teacher and Student.Tutors = Student
}
/* Every student in a class is at least tutored by all the teachers
 * assigned to that class. */
pred inv14 {
    all c:Class, s:Student | some t:Teacher | t.Teaches = c implies s in t.Tutors.s
}
/* The tutoring chain of every person eventually reaches a Teacher. */
pred inv15 {
    all s:Student | some t:Teacher | s in t.*Tutors
}
/*======== IFF PERFECT ORACLE ===============*/
/* Perfect Oracle for inv1 */
pred inv1_OK {
    Person in Student
}
assert inv1_Repaired {
    inv1[] iff inv1_OK[]
}

/* Perfect Oracle for inv2 */
pred inv2_OK {
    no Teacher
}
assert inv2_Repaired {
    inv2[] iff inv2_OK[]
}

/* Perfect Oracle for inv3 */
pred inv3_OK {
    no Student & Teacher
}
assert inv3_Repaired {
    inv3[] iff inv3_OK[]
}

/* Perfect Oracle for inv4 */
pred inv4_OK {
    Person in (Student + Teacher)
}
assert inv4_Repaired {
    inv4[] iff inv4_OK[]
}

/* Perfect Oracle for inv5 */
pred inv5_OK {
    some Teacher.Teaches
}
assert inv5_Repaired {
    inv5[] iff inv5_OK[]
}

/* Perfect Oracle for inv6 */
pred inv6_OK {
    Teacher.Teaches = Class and Teacher in Teacher.Teaches.Tutors
}
assert inv6_Repaired {
    inv6[] iff inv6_OK[]
}

/* Perfect Oracle for inv7 */
pred inv7_OK {
    Teacher.Teaches = Class and Teacher in Class.Groups.Tutors
}
assert inv7_Repaired {
    inv7[] iff inv7_OK[]
}

/* Perfect Oracle for inv8 */
pred inv8_OK {
    all t:Teacher | lone t.Teaches
}
assert inv8_Repaired {
    inv8[] iff inv8_OK[]
}

/* Perfect Oracle for inv9 */
pred inv9_OK {
    all c:Class | lone Teacher & c.Teaches
}
assert inv9_Repaired {
    inv9[] iff inv9_OK[]
}

/* Perfect Oracle for inv10 */
pred inv10_OK {
    all c:Class, s:Student | some c.Groups[s]
}
assert inv10_Repaired {
    inv10[] iff inv10_OK[]
}

/* Perfect Oracle for inv11 */
pred inv11_OK {
    all c:Class | some c.Teaches && some t:Teacher | t.Teaches = c
}
assert inv11_Repaired {
    inv11[] iff inv11_OK[]
}

/* Perfect Oracle for inv12 */
pred inv12_OK {
    all t:Teacher | some t.Teaches.Groups
}
assert inv12_Repaired {
    inv12[] iff inv12_OK[]
}

/* Perfect Oracle for inv13 */
pred inv13_OK {
    Teacher.Tutors = Teacher and Student.Tutors = Student
}
assert inv13_Repaired {
    inv13[] iff inv13_OK[]
}

/* Perfect Oracle for inv14 */
pred inv14_OK {
    all c:Class, s:Student | some t:Teacher | t.Teaches = c implies s in t.Tutors.s
}
assert inv14_Repaired {
    inv14[] iff inv14_OK[]
}

/* Perfect Oracle for inv15 */
pred inv15_OK {
    all s:Student | some t:Teacher | s in t.*Tutors
}
assert inv15_Repaired {
    inv15[] iff inv15_OK[]
}

/* Check all repaired assertions */
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