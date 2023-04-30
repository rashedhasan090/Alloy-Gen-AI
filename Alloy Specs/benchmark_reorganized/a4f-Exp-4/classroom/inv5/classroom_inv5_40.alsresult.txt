Fixed code:

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
    some t : Teacher | t.Teaches != none
}
/* Every teacher has classes assigned. */
pred inv6 {
    Teacher.teaches = Class
}
/* Every class has teachers assigned. */
pred inv7 {
    Class in Teacher.teaches
}
/* Teachers are assigned at most one class. */
pred inv8 {
    all t : Teacher | lone t.Teaches 
}
/* No class has more than one teacher assigned. */
pred inv9 {
    all c : Class | lone Teachers & Teaches[c]
}
/* For every class, every student has a group assigned. */
pred inv10 {
    all c : Class, s : Student | some g : Group | g in c.Groups[s]
}
/* A class only has groups if it has a teacher assigned. */
pred inv11 {
    all c : Class | some t : Teacher | t.Teaches[c] implies some g : Person -> Group | c.Groups = g
}
/* Each teacher is responsible for some groups. */
pred inv12 {
    all t : Teacher | some c : Class | t.Teaches[c] implies some g : Person -> Group | c.Groups = g
}
/* Only teachers tutor, and only students are tutored. */
pred inv13 {
    Teacher.Tutors = Teacher and Student.Tutors = Student 
}
/* Every student in a class is at least tutored by all the teachers
* assigned to that class. */
pred inv14 {
    all c : Class, s : Student |
    all t : c.Teaches.Teacher |
    some g : c.Groups | g[s] = g[t]
}
/* The tutoring chain of every person eventually reaches a Teacher. */
pred inv15 {
    all p : Person |
    some t : Teacher |
    p in t.^Tutors
}

/* Assertions */

assert Inv1 {
    inv1
}

assert Inv2 {
    inv2
}

assert Inv3 {
    inv3
}

assert Inv4 {
    inv4
}

assert Inv5 {
    inv5
}

assert Inv6 {
    inv6
}

assert Inv7 {
    inv7
}

assert Inv8 {
    inv8
}

assert Inv9 {
    inv9
}

assert Inv10 {
    inv10
}

assert Inv11 {
    inv11
}

assert Inv12 {
    inv12
}

assert Inv13 {
    inv13
}

assert Inv14 {
    inv14
}

assert Inv15 {
    inv15
}

/* Check all assertions */

check Inv1
check Inv2
check Inv3
check Inv4
check Inv5
check Inv6
check Inv7
check Inv8
check Inv9
check Inv10
check Inv11
check Inv12
check Inv13
check Inv14
check Inv15