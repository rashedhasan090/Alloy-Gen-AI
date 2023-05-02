/* Fixed Alloy specification */

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
    some c:Class | c.Teaches = Teacher
}

/* Every teacher has classes assigned. */
pred inv6 {
    all t:Teacher | t.Teaches != none
}

/* Every class has teachers assigned. */
pred inv7 {
    all c:Class | c.Teaches != none
}

/* Teachers are assigned at most one class. */
pred inv8 {
    all t:Teacher | lone t.Teaches
}

/* No class has more than one teacher assigned. */
pred inv9 {
    all c:Class | lone t:Teacher | t in c.Teaches
}

/* For every class, every student has a group assigned. */
pred inv10 {
    all c:Class, s:Student | some g:c.Groups | g.s
}

/* A class only has groups if it has a teacher assigned. */
pred inv11 {
    all c:Class | (some c.Teaches) implies some t:Teacher | t in c.Teaches
}

/* Each teacher is responsible for some groups. */
pred inv12 {
    all t:Teacher | some c:t.Teaches | some g:c.Groups
}

/* Only teachers tutor, and only students are tutored. */
pred inv13 {
    Teacher.Tutors = Person.Teacher and Student.Tutors = none
}

/* Every student in a class is tutored by at least one teacher assigned to that class. */
pred inv14 {
    all c:Class, s:Student | some t:c.Teaches | t in s.Tutors
}

/* The tutoring chain of every person eventually reaches a Teacher. */
pred inv15 {
    all s:Person | some t:Teacher | t in s.^Tutors
}

run { 
    inv1 
    inv2 
    inv3 
    inv4 
    inv5 
    inv6 
    inv7 
    inv8 
    inv9 
    inv10
    inv11 
    inv12 
    inv13 
    inv14 
    inv15 
} for 5 but exactly 1 Teacher, 10 Person, 5 Group, 5 Class, 5 Student, 5 Teacher.Teaches, 5 Class.Teaches, 5 Class.Groups, 2 Person.Tutors

/* ========= IFF PERFECT ORACLE =============== */

/* Repaired invariant inv1 */
pred inv1_OK {
    Person in Student
}
assert inv1_Repaired {
    inv1[] iff inv1_OK[]
}

/* Repaired invariant inv2 */
pred inv2_OK {
    no Teacher
}
assert inv2_Repaired {
    inv2[] iff inv2_OK[]
}

/* Repaired invariant inv3 */
pred inv3_OK {
    no Student & Teacher
}
assert inv3_Repaired {
    inv3[] iff inv3_OK[]
}

/* Repaired invariant inv4 */
pred inv4_OK {
    Person = Student + Teacher
}
assert inv4_Repaired {
    inv4[] iff inv4_OK[]
}

/* Repaired invariant inv5 */
pred inv5_OK {
    some c: Class | some t: Teacher | t in c.Teaches
}
assert inv5_Repaired {
    inv5[] iff inv5_OK[]
}

/* Repaired invariant inv6 */
pred inv6_OK {
    all t:Teacher | some c:t.Teaches
}
assert inv6_Repaired {
    inv6[] iff inv6_OK[]
}

/* Repaired invariant inv7 */
pred inv7_OK {
    all c:Class | some t:Teacher | t in c.Teaches
}
assert inv7_Repaired {
    inv7[] iff inv7_OK[]
}

/* Repaired invariant inv8 */
pred inv8_OK {
    all t:Teacher | lone t.Teaches
}
assert inv8_Repaired {
    inv8[] iff inv8_OK[]
}

/* Repaired invariant inv9 */
pred inv9_OK {
    all c:Class | lone t:Teacher | t in c.Teaches
}
assert inv9_Repaired {
    inv9[] iff inv9_OK[]
}

/* Repaired invariant inv10 */
pred inv10_OK {
    all c:Class, s:Student | some g:c.Groups | g.s
}
assert inv10_Repaired {
    inv10[] iff inv10_OK[]
}

/* Repaired invariant inv11 */
pred inv11_OK {
    all c:Class | (some c.Teaches) implies some t:Teacher | t in c.Teaches
}
assert inv11_Repaired {
    inv11[] iff inv11_OK[]
}

/* Repaired invariant inv12 */
pred inv12_OK {
    all t:Teacher | some c: t.Teaches | some g: c.Groups
}
assert inv12_Repaired {
    inv12[] iff inv12_OK[]
}

/* Repaired invariant inv13 */
pred inv13_OK {
    Teacher.Tutors = Person.Teacher and Student.Tutors = none
}
assert inv13_Repaired {
    inv13[] iff inv13_OK[]
}

/* Repaired invariant inv14 */
pred inv14_OK {
    all c:Class, s:Student | some t:c.Teaches | t in s.Tutors
}
assert inv14_Repaired {
    inv14[] iff inv14_OK[]
}

/* Repaired invariant inv15 */
pred inv15_OK {
    all s:Person | some t:Teacher | t in s.^Tutors
}
assert inv15_Repaired {
    inv15[] iff inv15_OK[]
}

/* Verify repaired invariants */
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