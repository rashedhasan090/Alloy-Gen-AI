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
all p:Person | p in (Student + Teacher)
}
/* There are some classes assigned to teachers. */
pred inv5 {
    some t:Teacher | t.Teaches != none
}
/* Every teacher has classes assigned. */
pred inv6 {
    all t:Teacher | t.Teaches != none
}
/* Every class has teachers assigned. */
pred inv7 {
    all c:Class | c -> Teacher != none
}
/* Teachers are assigned at most one class. */
pred inv8 {
    all t:Teacher | lone t.Teaches
}
/* No class has more than a teacher assigned. */
pred inv9 {
    all c:Class | lone t:Teacher | c -> t
}
/* For every class, every student has a group assigned. */
pred inv10 {
    all c:Class, s:Student | some c.Groups[s]
}
/* A class only has groups if it has a teacher assigned. */
pred inv11 {
    all c:Class | some t:Teacher | c -> t implies some c.Groups
}
/* Each teacher is responsible for some groups. */
pred inv12 {
    all t:Teacher | some c:Class | c -> t implies some c.Groups[t]
}
/* Only teachers tutor, and only students are tutored. */
pred inv13 {
    all t:Teacher | t.Tutors in Teacher
    all s:Student | s.Tutors in Student
    Teacher & Student = none
}
/* Every student in a class is at least tutored by all the teachers
 * assigned to that class. */
pred inv14 {
    all c:Class, s:Student |
        let teachers = c.Teaches & Teacher |
            s.Tutors in teachers.Tutors
}
/* The tutoring chain of every person eventually reaches a Teacher. */
pred inv15 {
    all s:Person | some t:Teacher | s in t.^Tutors
}

/* Repaired Invariants */
pred inv1_repaired {
    Person in Student
}

assert inv1_Repaired {
    inv1[] iff inv1_repaired[]
}

pred inv2_repaired {
    no Teacher
}

assert inv2_Repaired {
    inv2[] iff inv2_repaired[]
}

pred inv3_repaired {
    no Student & Teacher = none
}

assert inv3_Repaired {
    inv3[] iff inv3_repaired[]
}

pred inv4_repaired {
    all p:Person | p in (Student + Teacher)
}

assert inv4_Repaired {
    inv4[] iff inv4_repaired[]
}

pred inv5_repaired {
    some t:Teacher | t.Teaches != none
}

assert inv5_Repaired {
    inv5[] iff inv5_repaired[]
}

pred inv6_repaired {
    all t:Teacher | t.Teaches != none
}

assert inv6_Repaired {
    inv6[] iff inv6_repaired[]
}

pred inv7_repaired {
    all c:Class | c -> Teacher != none
}

assert inv7_Repaired {
    inv7[] iff inv7_repaired[]
}

pred inv8_repaired {
    all t:Teacher | lone t.Teaches
}

assert inv8_Repaired {
    inv8[] iff inv8_repaired[]
}

pred inv9_repaired {
    all c:Class | lone t:Teacher | c -> t
}

assert inv9_Repaired {
    inv9[] iff inv9_repaired[]
}

pred inv10_repaired {
    all c:Class, s:Student | some c.Groups[s]
}

assert inv10_Repaired {
    inv10[] iff inv10_repaired[]
}

pred inv11_repaired {
    all c:Class | some t:Teacher | c -> t implies some c.Groups
}

assert inv11_Repaired {
    inv11[] iff inv11_repaired[]
}

pred inv12_repaired {
    all t:Teacher | some c:Class | c -> t implies some c.Groups[t]
}

assert inv12_Repaired {
    inv12[] iff inv12_repaired[]
}

pred inv13_repaired {
    all t:Teacher | t.Tutors in Teacher
    all s:Student | s.Tutors in Student
    Teacher & Student = none
}

assert inv13_Repaired {
    inv13[] iff inv13_repaired[]
}

pred inv14_repaired {
    all c:Class, s:Student |
        let teachers = c.Teaches & Teacher |
            s.Tutors in teachers.Tutors
}

assert inv14_Repaired {
    inv14[] iff inv14_repaired[]
}

pred inv15_repaired {
    all s:Person | some t:Teacher | s in t.^Tutors
}

assert inv15_Repaired {
    inv15[] iff inv15_repaired[]
}

check inv1_Repaired
check inv2_Repaired
check inv3_Repaired
check inv4_Repaired
check inv5_Repaired
check inv6_Repaired
check inv7_Repaired
check inv8_Repaired
check inv9_Repaired
check inv10_Repaired
check inv11_Repaired
check inv12_Repaired
check inv13_Repaired
check inv14_Repaired
check inv15_Repaired