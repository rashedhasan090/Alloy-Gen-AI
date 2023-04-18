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
    /* Some classes are assigned to teachers. */
    Teachers : set Teacher
}

/* Some persons are teachers. */
sig Teacher extends Person {}

/* Some persons are students. */
sig Student extends Person {}

/* Every person is either a student or a teacher. */
pred inv1 {
    Person in Student + Teacher
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

/* Some classes are assigned to teachers. */
pred inv5 {
    some Class.Teachers
}

/* Every teacher has classes assigned. */
pred inv6 {
    Teacher.Teaches = Class & Teacher.Teachers
}

/* Every class has teachers assigned. */
pred inv7 {
    Class.Teachers = Teacher & Class.Teaches
}

/* Teachers are assigned at most one class. */
pred inv8 {
    all t:Teacher | lone t.Teaches
}

/* No class has more than one teacher assigned. */
pred inv9 {
    all c:Class | lone c.Teachers
}

/* For every class, every student has a group assigned. */
pred inv10 {
    all c:Class, s:Student | some c.Groups[s]
}

/* A class only has groups if it has a teacher assigned. */
pred inv11 {
    all c : Class | (some c.Groups) implies some c.Teachers
}

/* Each teacher is responsible for some groups. */
pred inv12 {
    all t : Teacher | some c : t.Teaches | some g : Group | c.Groups[t] = g
}

/* Only teachers tutor, and only students are tutored. */
pred inv13 {
    Tutors.Person in Teacher and Person.Tutors in Student
}

/* Every student in a class is at least tutored by all the teachers
 * assigned to that class. */
pred inv14 {
    all c : Class, s : Student | some c.Groups[s] implies all t : c.Teachers | s in t.Tutors
}

/* The tutoring chain of every person eventually reaches a Teacher. */
pred inv15 {
    all s : Person | some t : Teacher | s in t.^Tutors
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
    Person in Student + Teacher
}

assert inv4_Repaired {
    inv4[] iff inv4_OK[]
}

pred inv5_OK {
    some Class.Teachers
}

assert inv5_Repaired {
    inv5[] iff inv5_OK[]
}

pred inv6_OK {
    Teacher.Teaches = Class & Class.Teachers
}

assert inv6_Repaired {
    inv6[] iff inv6_OK[]
}

pred inv7_OK {
    Class.Teachers = Teacher & Class.Teaches
}

assert inv7_Repaired {
    inv7[] iff inv7_OK[]
}

pred inv8_OK {
    all t:Teacher | lone t.Teaches
}

assert inv8_Repaired {
    inv8[] iff inv8_OK[]
}

pred inv9_OK {
    all c:Class | lone c.Teachers
}

assert inv9_Repaired {
    inv9[] iff inv9_OK[]
}

pred inv10_OK {
    all c:Class, s:Student | some c.Groups[s]
}

assert inv10_Repaired {
    inv10[] iff inv10_OK[]
}

pred inv11_OK {
    all c : Class | (some c.Groups) implies some c.Teachers
}

assert inv11_Repaired {
    inv11[] iff inv11_OK[]
}

pred inv12_OK {
    all t : Teacher | some c : t.Teaches | some g : Group | c.Groups[t] = g
}

assert inv12_Repaired {
    inv12[] iff inv12_OK[]
}

pred inv13_OK {
    Tutors.Person in Teacher and Person.Tutors in Student
}

assert inv13_Repaired {
    inv13[] iff inv13_OK[]
}

pred inv14_OK {
    all c : Class, s : Student | some c.Groups[s] implies all t : c.Teachers | s in t.Tutors
}

assert inv14_Repaired {
    inv14[] iff inv14_OK[]
}

pred inv15_OK {
    all s : Person | some t : Teacher | s in t.^Tutors
}

assert inv15_Repaired {
    inv15[] iff inv15_OK[]
}

/* Perfect oracle check commands */
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

/* Repair commands */
run inv15_OK
assert inv15_Repaired {
    inv15[] iff inv15_OK[]
}
check inv15_Repaired