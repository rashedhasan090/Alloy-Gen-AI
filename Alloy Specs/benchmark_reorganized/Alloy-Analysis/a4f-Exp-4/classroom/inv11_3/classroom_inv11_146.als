Fixed code:

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
    some Teacher.Teaches
}
/* Every teacher has classes assigned. */
pred inv6 {
    Teacher.Teaches = Class
}
/* Every class has teachers assigned. */
pred inv7 {
    Teacher.Teaches = Class
}
/* Teachers are assigned at most one class. */
pred inv8 {
    all t: Teacher | lone t.Teaches
}
/* No class has more than one teacher assigned. */
pred inv9 {
    all c: Class | lone p: Person | p -> c in Teaches
}
/* For every class, every student has a group assigned. */
pred inv10 {
    all c: Class, s: Student | some g: Group | c.Groups[s] = g
}
/* A class only has groups if it has a teacher assigned. */
pred inv11 {
    all c: Class, g: Group | some t: Teacher | c.Groups[t] = g iff t -> c in Teaches
}
/* Each teacher is responsible for some groups. */
pred inv12 {
    all t: Teacher | some g: Group | g in (t.Teaches).Groups
}
/* Only teachers tutor, and only students are tutored. */
pred inv13 {
    all p: Person | p.Tutors in Teacher and p not in Teacher implies p.Tutors in Student
}
/* Every student in a class is at least tutored by all the teachers
 * assigned to that class. */
pred inv14 {
    all c: Class, s: Student | all t: Teacher | c.Groups[s] != none implies t -> s in Tutors
}
/* The tutoring chain of every person eventually reaches a Teacher. */
pred inv15 {
    all p: Person | some t: Teacher | p in t.^Tutors
}

/* IFF Perfect Oracle */
pred inv11_OK {
    all c: Class, g: Group | some t: Teacher | c.Groups[t] = g implies t -> c in Teaches
}
assert inv11_Repaired {
    inv11[] iff inv11_OK[]
} 

/* Repair commands for the fixed invariant */
run inv11_Repaired{} for exactly 1 Person, 1 Teacher, 1 Class, 1 Group, 1 Person->Group, 1 Teacher->Class 

/* Perfect Oracle Commands */
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
check inv11_Repaired
check inv12
check inv13
check inv14
check inv15