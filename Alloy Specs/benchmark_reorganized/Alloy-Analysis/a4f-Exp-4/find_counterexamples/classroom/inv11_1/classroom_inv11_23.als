/* Fixed code below */

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
/* Every person is a student or a teacher. */
pred inv1 {
    Person in Teacher + Student
}
/* There are no teachers. */
pred inv2 {
    no Teacher
}
/* No person is both a student and a teacher. */
pred inv3 {
    disj[Student, Teacher]
}
/* No person is neither a student nor a teacher. */
pred inv4 {
    Person in Teacher + Student
}
/* There are some classes assigned to teachers. */
pred inv5 {
    some Teacher.Teaches
}
/* Every teacher has classes assigned. */
pred inv6 {
    Teacher in Teaches.Class
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
    all c: Class | lone t: Teacher | t -> c in Teaches
}
/* For every class, every student has a group assigned. */
pred inv10 {
    all c: Class, s: Student | some g: Group | c -> s -> g in Groups
}
/* A class only has groups if it has a teacher assigned. */
pred inv11 {
    all c: Class | some t: Teacher | t -> c in Teaches implies some g: Group | c -> g in Groups
}
/* Each teacher is responsible for some groups. */
pred inv12 {
    all t: Teacher | some g: Group | t.Teaches -> g in Groups
}
/* Only teachers tutor, and only students are tutored. */
pred inv13 {
    Tutors.Person in Teacher and Person.Tutors in Student
}
/* Every student in a class is at least tutored by all the teachers assigned to that class. */
pred inv14 {
    all c: Class, s: Student | all t: Teacher | c -> s -> _ in Groups implies (t -> c in Teaches implies t -> s in Tutors)
}
/* The tutoring chain of every person eventually reaches a Teacher. */
pred inv15 {
    all s: Student | some t: Teacher | ^Tutors.s = t
} 

/* Check all invariants hold */
check inv1
check inv2
check inv3
check inv4
check inv5
check inv6
check inv7
check inv8
check inv9
check inv10
check inv11
check inv12
check inv13
check inv14
check inv15