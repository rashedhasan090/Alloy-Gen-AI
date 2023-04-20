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
    /* The teacher of the class. */
    teacher : Teacher lone -> one
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

/* Some classes are assigned to teachers. */
pred inv5 {
    some Teacher.Teaches
}

/* Every teacher has classes assigned. */
pred inv6 {
    Teacher in Teaches.tutor
}

/* Every class has a teacher assigned (a class can have many teachers.) */
pred inv7 {
    all c : Class | (some c.Groups) implies some t : Teacher | t.teaches = c
}

/* Teachers are assigned at most one class. */
pred inv8 {
    all t : Teacher | lone t.Teaches
}

/* No class has more than one teacher assigned. */
pred inv9 {
    all c : Class | lone t : Teacher | t.teaches = c
}

/* For every class, every student has a group assigned. */
pred inv10 {
    all c : Class, s : Student | some c.Groups[s]
}

/* A class only has groups if it has a teacher assigned. */
pred inv11 {
    all c : Class | (some c.Groups) implies some t : Teacher | t.teaches = c
}

/* Each teacher is responsible for some groups. */
pred inv12 {
    all t : Teacher | some (t.Teaches).Groups
}

/* Only teachers tutor, and only students are tutored. */
pred inv13 {
    Tutors.Person in Teacher and Person.Tutors in Student
}

/* Every student in a class is at least tutored by all the teachers assigned to that class. */
pred inv14 {
    all s : Person, c : Class, g : Group | (c -> s -> g in Groups) implies all t : Teacher | t.teaches = c implies t -> s in Tutors
}

/* The tutoring chain of every person eventually reaches a Teacher. */
pred inv15 {
    all s : Person | some Teacher & ^Tutors.s
}

/* IFF PERFECT ORACLE */
assert inv1_Repaired {
    inv1[] iff Person in Student
}

assert inv2_Repaired {
    inv2[] iff no Teacher
}

assert inv3_Repaired {
    inv3[] iff no Student & Teacher
}

assert inv4_Repaired {
    inv4[] iff Person in Student + Teacher
}

assert inv5_Repaired {
    inv5[] iff some Teacher.Teaches
}

assert inv6_Repaired {
    inv6[] iff Teacher in Teaches.tutor
}

assert inv7_Repaired {
    inv7[] iff all c : Class | (some c.Groups) implies some t : Teacher | t.teaches = c
}

assert inv8_Repaired {
    inv8[] iff all t : Teacher | lone t.Teaches
}

assert inv9_Repaired {
    inv9[] iff all c : Class | lone t : Teacher | t.teaches = c
}

assert inv10_Repaired {
    inv10[] iff all c : Class, s : Student | some c.Groups[s]
}

assert inv11_Repaired {
    inv11[] iff all c : Class | (some c.Groups) implies some t : Teacher | t.teaches = c
}

assert inv12_Repaired {
    inv12[] iff all t : Teacher | some (t.Teaches).Groups
}

assert inv13_Repaired {
    inv13[] iff Tutors.Person in Teacher and Person.Tutors in Student
}

assert inv14_Repaired {
    inv14[] iff all s : Person, c : Class, g : Group | (c -> s -> g in Groups) implies all t : Teacher | t.teaches = c implies t -> s in Tutors
}

assert inv15_Repaired {
    inv15[] iff all s : Person | some Teacher & ^Tutors.s
}

/* Run Alloys checks */
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

/* Run repaired predicate inv7 */
pred repair_pred_1{
    inv7[] iff all c : Class | (some c.Groups) implies some t : Teacher | t.teaches = c
}
run repair_pred_1

/* Check repaired assert inv7 */
assert repair_assert_1{
    inv7[] iff all c : Class | (some c.Groups) implies some t : Teacher | t.teaches = c
}
check repair_assert_1