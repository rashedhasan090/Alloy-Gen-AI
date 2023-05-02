
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

/* There is at least one teacher. */
pred inv2 {
    some Teacher
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
    Teacher.Teaches = Class
}

/* Every class has teachers assigned. */
pred inv7 {
    Class in Teacher.Teaches
}

/* Teachers are assigned at most one class. */
pred inv8 {
    all t: Teacher | lone t.Teaches
}

/* No class has more than one teacher assigned. */
pred inv9 {
    all c: Class | lone Teachers.c
}

/* For every class, every student has a group assigned. */
pred inv10 {
    all c: Class, s: Student | some s.(c.Groups)
}

/* A class only has groups if it has a teacher assigned. */
pred inv11 {
    all c: Class | some t: Teacher | t.Teaches = c and c.Groups != univ.Person -> univ.Group
}

/* Each teacher is responsible for some groups. */
pred inv12 {
    all t: Teacher | some (t.Teaches).Groups
}

/* Only teachers tutor, and only students are tutored. */
pred inv13 {
    Tutors.Person in Teacher and Person.Tutors in Student
}

/* Every student in a class is tutored by at least one teacher
   assigned to that class. */
pred inv14 {
    all s: Student, c: Class | (some c.Groups.s) implies (some t: Teacher | t.Teaches = c and s in t.Tutors)
}

/* The tutoring chain of every person eventually reaches a Teacher. */
pred inv15 {
    all s: Person | some Teacher & ^Tutors.s
}

run inv1_OK for 5 but 2 Person, 2 Student, 1 Teacher
run inv2_OK for 5 but 2 Person, 1 Student, 2 Teacher
run inv3_OK for 5 but 1 Student, 1 Teacher
run inv4_OK for 5 but 2 Person, 1 Student, 1 Teacher
run inv5_OK for 5 but 1 Class, 1 Teacher.Teaches
run inv6_OK for 5 but 1 Class, 1 Teacher.Teaches, 1 Teacher
run inv7_OK for 5 but 1 Class, 1 Teacher.Teaches, 1 Teacher
run inv8_OK for 5 but 1 Teacher, 1 Teacher.Teaches
run inv9_OK for 5 but 1 Class, 1 Teacher.Teaches, 1 Teacher
run inv10_OK for 5 but 1 Class, 1 Student, 1 Group
run inv11_OK for 5 but 1 Class, 1 Student, 1 Group, 1 Teacher
run inv12_OK for 5 but 1 Teacher, 1 Teacher.Teaches, 1 Group
run inv13_OK for 5 but 1 Teacher, 1 Student, 1 Teacher.Tutors
run inv14_OK for 5 but 1 Class, 1 Student, 1 Teacher, 1 Group
run inv15_OK for 5 but 1 Teacher, 1 Student, 1 Teacher.Tutors

check inv1_Repaired for 5 but 2 Person, 2 Student, 1 Teacher
check inv2_Repaired for 5 but 2 Person, 1 Student, 2 Teacher
check inv3_Repaired for 5 but 1 Student, 1 Teacher
check inv4_Repaired for 5 but 2 Person, 1 Student, 1 Teacher
check inv5_Repaired for 5 but 1 Class, 1 Teacher.Teaches
check inv6_Repaired for 5 but 1 Class, 1 Teacher.Teaches, 1 Teacher
check inv7_Repaired for 5 but 1 Class, 1 Teacher.Teaches, 1 Teacher
check inv8_Repaired for 5 but 1 Teacher, 1 Teacher.Teaches
check inv9_Repaired for 5 but 1 Class, 1 Teacher.Teaches, 1 Teacher
check inv10_Repaired for 5 but 1 Class, 1 Student, 1 Group
check inv11_Repaired for 5 but 1 Class, 1 Student, 1 Group, 1 Teacher
check inv12_Repaired for 5 but 1 Teacher, 1 Teacher.Teaches, 1 Group
check inv13_Repaired for 5 but 1 Teacher, 1 Student, 1 Teacher.Tutors
check inv14_Repaired for 5 but 1 Class, 1 Student, 1 Teacher, 1 Group
check inv15_Repaired for 5 but 1 Teacher, 1 Student, 1 Teacher.Tutors