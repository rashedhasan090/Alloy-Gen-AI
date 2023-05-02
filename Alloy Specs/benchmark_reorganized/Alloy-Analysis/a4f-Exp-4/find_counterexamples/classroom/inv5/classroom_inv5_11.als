The fixed code is:

/* The registered persons. */
sig Person {
    /* Each person tutors a set of persons. */
    Tutors : set Person,
    /* Each person teaches a set of classes. */
    Teaches : set Class
}
/* The registered groups. */
sig Group {}
/* The registered classes. */
sig Class {
    /* Each class has a set of persons assigned to a group. */
    Groups : Person -> Group
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
/* There are some classes assigned to teachers. */
pred inv5 {
    some c : Class | some t : Teacher | c in t.Teaches
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
    all t : Teacher | lone t.Teaches
}
/* No class has more than one teacher assigned. */
pred inv9 {
    all c : Class | lone p : Person | p -> c in Teaches implies p in Teacher
}
/* For every class, every student has a group assigned. */
pred inv10 {
    all c : Class, s : Student | some g : Group | c.Groups[s] = g
}
/* A class only has groups if it has a teacher assigned. */
pred inv11 {
    all c : Class | (some c.Groups) implies some t : Teacher | c in t.Teaches
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
    all c : Class, s : Student, t : (Teacher & c.Teaches) | some g : Group |
        c.Groups[s] = g and g = c.Groups[t] and t -> s in Tutors
}
/* The tutoring chain of every person eventually reaches a Teacher. */
pred inv15 {
    all s : Person | some t : Teacher | s in t.^Tutors
}

/* Assertions */
run {
    inv1
    inv2
    inv3
    inv4
    inv5
    inv6
    inv7
    inv8
    inv9
    inv10
    inv11
    inv12
    inv13
    inv14
    inv15
} for 5 but exactly 1 Teacher, 3 Student, 3 Class, 4 Group  /* example instance */