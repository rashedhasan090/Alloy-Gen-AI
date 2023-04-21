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
    /* Some teachers are assigned to a class. */
    AssignedTeachers : set Teacher
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

/* Some classes have assigned teachers. */
pred inv5 {
    some c: Class | c.AssignedTeachers != {}
}

/* Every teacher has a class assigned. */
pred inv6 {
    all t: Teacher | some c: Class | c.AssignedTeachers = t.Teaches
}

/* Every class has assigned teachers. */
pred inv7 {
    all c: Class | c.AssignedTeachers != {} 
}

/* Teachers are assigned at most one class. */
pred inv8 {
    all t: Teacher | #t.Teaches <= 1
}

/* No class has more than one teacher assigned. */
pred inv9 {
    all c: Class | #c.AssignedTeachers <= 1 
}

/* For every class, every student has a group assigned. */
pred inv10 {
    all c: Class, s: Student | some g: Group | (s->g) in c.Groups
}

/* A class only has assigned groups if it has assigned teachers. */
pred inv11 {
    all c: Class | (some g: Group | (t: Teacher) | g in c.Groups && t in c.AssignedTeachers && t.teaches= c) implies c.AssignedTeachers != {}
}

/* Each teacher is responsible for some groups. */
pred inv12 {
    all t: Teacher | some g: Group | g in t.Teaches.Groups
}

/* Only teachers tutor, and only students are tutored. */
pred inv13 {
    all t: Teacher | t.Tutors in Teacher
    all s: Student | s.Tutors in Student
    all t: Teacher, s: Student | t.Tutors & s.Tutors = none
}

/* Every student in a class is at least tutored by all the assigned teachers. */
pred inv14 {
    all c: Class, s: Student | some g: Group | (s->g) in c.Groups implies all t: c.AssignedTeachers | s in t.Tutors
}

/* The tutoring chain of every person eventually reaches a Teacher. */
pred inv15 {
    all s: Student | some Teacher & ^s.Tutors
}

/* IFF PERFECT ORACLE */
pred inv1_OK {
    Person in Student
}

assert inv1_Repaired {
    inv1[] iff inv1_OK[]
}

pred inv2_OK {
    no Teacher 
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
    some c: Class | c.AssignedTeachers != {}
}

assert inv5_Repaired {
    inv5[] iff inv5_OK[]
}

pred inv6_OK {
    Teacher in Teaches.Class
}

assert inv6_Repaired {
    inv6[] iff inv6_OK[]
}

pred inv7_OK {
    Class in AssignedTeachers.Teaches
}

assert inv7_Repaired {
    inv7[] iff inv7_OK[]
}

pred inv8_OK {
    all t: Teacher | lone t.Teaches
}

assert inv8_Repaired {
    inv8[] iff inv8_OK[]
}

pred inv9_OK {
    all c: Class | lone c.AssignedTeachers 
}

assert inv9_Repaired {
    inv9[] iff inv9_OK[]
}

pred inv10_OK {
    all c: Class, s: Student | some g: Group | (s->g) in c.Groups 
}

assert inv10_Repaired {
    inv10[] iff inv10_OK[]
}

pred inv11_OK {
    all c: Class | (some g: Group | (t: Teacher) | g in c.Groups && t in c.AssignedTeachers && t.teaches= c) implies c.AssignedTeachers != {}
}

assert inv11_Repaired {
    inv11[] iff inv11_OK[]
}

pred inv12_OK {
    all t: Teacher | some g: Group | g in t.Teaches.Groups
}

assert inv12_Repaired {
    inv12[] iff inv12_OK[]
}

pred inv13_OK {
    Tutors.Person in Teacher and Tutors.Person in Teacher implies Tutors.Person in Person
}

assert inv13_Repaired {
    inv13[] iff inv13_OK[]
}

pred inv14_OK {
    all c: Class, s: Student | some g: Group | (s -> g in c.Groups) implies all t: c.AssignedTeachers | s in t.Tutors
}

assert inv14_Repaired {
    inv14[] iff inv14_OK[]
}

pred inv15_OK {
    all s: Student | some Teacher & ^Tutors.s 
}

assert inv15_Repaired {
    inv15[] iff inv15_OK[]
}

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