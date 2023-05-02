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
    Groups : Person -> Group
}

/* Some persons are teachers. */

sig Teacher extends Person  {}

/* Some persons are students. */

sig Student extends Person  {}

/* Every person is a student. */

pred inv1 {
    Person in Student ----correct
}

/* There are no teachers. */

pred inv2 {
    no Teacher ----correct
}

/* No person is both a student and a teacher. */

pred inv3 {
    no Student & Teacher ----correct
}

/* No person is neither a student nor a teacher. */

pred inv4 {
    Person = Student + Teacher ----correct
}

/* There are some classes assigned to teachers. */

pred inv5 {
    some t: Teacher | some t.Teaches ----correct
}

/* Every teacher has classes assigned. */

pred inv6 {
    Teacher = Teaches.Person ----correct
}

/* Every class has teachers assigned. */

pred inv7 {
    Class = Teacher.Teaches ----correct
}

/* Teachers are assigned at most one class. */

pred inv8 {
    all t: Teacher | lone t.Teaches ----correct
}

/* No class has more than one teacher assigned. */

pred inv9 {
    all c: Class | lone t: Teacher | t -> c in Teaches ----correct
}

/* For every class, every student has a group assigned. */

pred inv10 {
    all c: Class, s: Student | some g: Group | c -> s -> g in Groups ----correct
}

/* A class only has groups if it has a teacher assigned. */

pred inv11 {
    all c: Class | (some c.Groups) implies some t: Teacher | t -> c in Teaches ----correct
}

/* Each teacher is responsible for some groups. */

pred inv12 {
    all t: Teacher | some g: Group | (t.Teaches).(Group & c.Groups) in g ----correct
}

/* Only teachers tutor, and only students are tutored. */

pred inv13 {
    Tutors.Person in Teacher and Person.Tutors in Student ----correct
}

/* Every student in a class is at least tutored by all the teachers
assigned to that class. */

pred inv14 {
    all c: Class, s: Student | some t: Teacher | t -> c in Teaches and t -> s in Tutors and c -> s -> g in Groups ----correct
}

/* The tutoring chain of every person eventually reaches a Teacher. */

pred inv15 {
    all s: Student | some t: Teacher | ^s.Tutors = t ----correct
}
/*======== IFF PERFECT ORACLE ===============*/

//Fixing Assert inv1
pred inv1_OK {
    Person in Student ----correct
}
assert inv1_Repaired {
    inv1[] iff inv1_OK[]
}

//Fixing Assert inv2

pred inv2_OK {
    no Teacher ----correct
}
assert inv2_Repaired {
    inv2[] iff inv2_OK[]
}

//Fixing Assert inv3

pred inv3_OK {
    no Student & Teacher ----correct
}
assert inv3_Repaired {
    inv3[] iff inv3_OK[]
}

//Fixing Assert inv4

pred inv4_OK {
    Person = Student + Teacher ----correct
}
assert inv4_Repaired {
    inv4[] iff inv4_OK[]
}

//Fixing Assert inv5

pred inv5_OK {
    some t: Teacher | some t.Teaches ----correct
}
assert inv5_Repaired {
    inv5[] iff inv5_OK[]
}

//Fixing Assert inv6

pred inv6_OK {
    Teacher = Teaches.Person ----correct
}
assert inv6_Repaired {
    inv6[] iff inv6_OK[]
}

//Fixing Assert inv7

pred inv7_OK {
    Class = Teacher.Teaches ----correct
}
assert inv7_Repaired {
    inv7[] iff inv7_OK[]
}

//Fixing Assert inv8

pred inv8_OK {
    all t: Teacher | lone t.Teaches ----correct
}
assert inv8_Repaired {
    inv8[] iff inv8_OK[]
}

//Fixing Assert inv9

pred inv9_OK {
    all c: Class | lone t: Teacher | t -> c in Teaches ----correct
}
assert inv9_Repaired {
    inv9[] iff inv9_OK[]
}

//Fixing Assert inv10

pred inv10_OK {
    all c: Class, s: Student | some g: Group | c -> s -> g in Groups ----correct
}
assert inv10_Repaired {
    inv10[] iff inv10_OK[]
}

//Fixing Assert inv11

pred inv11_OK {
    all c: Class | (some c.Groups) implies some t: Teacher | t -> c in Teaches ----correct
}
assert inv11_Repaired {
    inv11[] iff inv11_OK[]
}

//Fixing Assert inv12

pred inv12_OK {
    all t: Teacher | some g: Group | (t.Teaches).(Group & c.Groups) in g ----correct
}
assert inv12_Repaired {
    inv12[] iff inv12_OK[]
}

//Fixing Assert inv13

pred inv13_OK {
    Tutors.Person in Teacher and Person.Tutors in Student ----correct
}
assert inv13_Repaired {
    inv13[] iff inv13_OK[]
}

//Fixing Assert inv14

pred inv14_OK {
    all c: Class, s: Student, g: Group | (c -> s -> g in Groups) implies
        some t: Teacher | t -> c in Teaches && t -> s in Tutors ----correct
}
assert inv14_Repaired {
    inv14[] iff inv14_OK[]
}

//Fixing Assert inv15

pred inv15_OK {
    all s: Student | some t: Teacher | ^s.Tutors = t ----correct
}
assert inv15_Repaired {
    inv15[] iff inv15_OK[]
}

------ PerfectOracleCommands
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

pred repair_pred_1{inv11[] iff inv11_OK[] }
run repair_pred_1
assert repair_assert_1{inv11[] iff inv11_OK[] }
check repair_assert_1