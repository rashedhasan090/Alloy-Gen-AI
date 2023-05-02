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
    some t: Teacher | t.Teaches != none
}
/* Every teacher has classes assigned. */
pred inv6 {
    Teacher.teaches = Class
}
/* Every class has teachers assigned. */
pred inv7 {
    Class.Teaches = Teacher
}
/* Teachers are assigned at most one class. */
pred inv8 {
    all t: Teacher | lone t.Teaches
}
/* No class has more than one teacher assigned. */
pred inv9 {
    all c: Class | lone c.Teaches
}
/* For every class, every student has a group assigned. */
pred inv10 {
    all c: Class, s: Student | some g: Group | (s->g) in c.Groups
}
/* A class only has groups if it has a teacher assigned. */
pred inv11 {
    all c: Class | some t: Teacher | t.Teaches = c and c.Groups != none
}
/* Each teacher is responsible for some groups. */
pred inv12 {
    all t: Teacher | some g: Group | (t.Teaches->g) in Class.Groups
}
/* Only teachers tutor, and only students are tutored. */
pred inv13 {
    Teacher.Tutors = Teacher and Student.Tutors = Student
}
/* Every student in a class is at least tutored by all the teachers
* assigned to that class. */
pred inv14 {
    all c: Class, s: Student | some t: Teacher | (t->c) in Teaches and (s->(c.Groups)) in Groups implies (t->s) in Tutors
}
/* The tutoring chain of every person eventually reaches a Teacher. */
pred inv15 {
    all s: Person | s in Teacher.*Tutors
}

/* Fixed assertions */
assert inv1_OK {
    inv1[]
}
assert inv2_OK {
    inv2[]
}
assert inv3_OK {
    inv3[]
}
assert inv4_OK {
    inv4[]
}
assert inv5_OK {
    inv5[]
}
assert inv6_OK {
    inv6[]
}
assert inv7_OK {
    inv7[]
}
assert inv8_OK {
    inv8[]
}
assert inv9_OK {
    inv9[]
}
assert inv10_OK {
    inv10[]
}
assert inv11_OK {
    inv11[]
}
assert inv12_OK {
    inv12[]
}
assert inv13_OK {
    inv13[]
}
assert inv14_OK {
    inv14[]
}
assert inv15_OK {
    inv15[]
}

/* Check that all assertions hold */
check inv1_OK
check inv2_OK
check inv3_OK
check inv4_OK
check inv5_OK
check inv6_OK
check inv7_OK
check inv8_OK
check inv9_OK
check inv10_OK
check inv11_OK
check inv12_OK
check inv13_OK
check inv14_OK
check inv15_OK