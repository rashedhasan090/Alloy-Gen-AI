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
    Person in Student + Teacher
}
/* There are some classes assigned to teachers. */
pred inv5 {
    some Teacher.Teaches
}
/* Every teacher has classes assigned. */
pred inv6 {
    Teacher = Teaches.Teacher
}
/* Every class has teachers assigned. */
pred inv7 {
    Class = Teacher.Teaches.Class
}
/* Teachers are assigned at most one class. */
pred inv8 {
    all t : Teacher | lone c : Class | t -> c in Teaches
}
/* No class has more than a teacher assigned. */
pred inv9 {
    all c : Class | lone p : Person | p -> c in Teaches
}
/* For every class, every student has a group assigned. */
pred inv10 {
    all c : Class, s : Student | some g : Group | c -> s -> g in Groups
}
/* A class only has groups if it has a teacher assigned. */
pred inv11 {
    all c : Class | (some c.Groups) implies some t : Teacher | t -> c in Teaches
}
/* Each teacher is responsible for some groups. */
pred inv12 {
    all t : Teacher | some c : t.Teaches | some g : Group | c -> g in Groups
}
/* Only teachers tutor, and only students are tutored. */
pred inv13 {
    Tutors.Person in Teacher and Tutors.Person in Student
}
/* Every student in a class is at least tutored by all the teachers assigned to that class. */
pred inv14 {
    all c : Class, s : Student | some t : c.Teaches.Teacher | t -> s in Tutors
}
/* The tutoring chain of every person eventually reaches a Teacher. */
pred inv15 {
    all s : Student | some t : Teacher | s in t.^Tutors
}

/* IFF PERFECT ORACLE */
pred repaired_inv8 {
    inv8[] iff all t: Teacher | lone c: t -> Teaches
}
assert repaired_inv8 {
    repaired_inv8[]
}