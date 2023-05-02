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
    Groups : Person lone -> Group
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
    all t:Teacher | lone t.Teaches
}
/* No class has more than a teacher assigned. */
pred inv9 {
    all c:Class | lone (Teaches.c & Teacher)
}
/* For every class, every student has a group assigned. */
pred inv10 {
    all c:Class, s:Student | some s.(c.Groups)
}
/* A class only has groups if it has a teacher assigned. */
pred inv11 {
    all c:Class | (some c.Groups) implies some Teacher & Teaches.c
}
/* Each teacher is responsible for some groups. */
pred inv12 {
    all t:Teacher | some (t.Teaches).Groups
}
/* Only teachers tutor, and only students are tutored. */
pred inv13 {
    Tutors.Person in Teacher and Person.Tutors in Student
}
/* Every student in a class is at least tutored by all the teachers
 * assigned to that class. */
pred inv14 {
    all s:Person, c:Class, t:Person, g:Group | (c -> s -> g in Groups) and t -> c in Teaches implies (t -> s) in Tutors
}
/* The tutoring chain of every person eventually reaches a Teacher. */
pred inv15 {
    all s:Person | some (Teacher & ^Tutors.s)
}

/*=================== ASSERTIONS ===================*/

/* Assertion 1 -- Person is only a student */
pred assertion1 {
    inv1
}
assert assert1 {
    assertion1
}

/* Assertion 2 -- There are no teachers */
pred assertion2 {
    inv2
}
assert assert2 {
    assertion2
}

/* Assertion 3 -- No person is a student and a teacher */
pred assertion3 {
    inv3
}
assert assert3 {
    assertion3
}

/* Assertion 4 -- Every person is either a student or a teacher */
pred assertion4 {
    inv4
}
assert assert4 {
    assertion4
}

/* Assertion 5 -- There are some classes assigned to teachers */
pred assertion5 {
    inv5
}
assert assert5 {
    assertion5
}

/* Assertion 6 -- Every teacher has classes assigned */
pred assertion6 {
    inv6
}
assert assert6 {
    assertion6
}

/* Assertion 7 -- Every class has teachers assigned */
pred assertion7 {
    inv7
}
assert assert7 {
    assertion7
}

/* Assertion 8 -- Each teacher is assigned at most one class */
pred assertion8 {
    inv8
}
assert assert8 {
    assertion8
}

/* Assertion 9 -- No class has more than one teacher assigned */
pred assertion9 {
    inv9
}
assert assert9 {
    assertion9
}

/* Assertion 10 -- For every class, every student has a group assigned */
pred assertion10 {
    inv10
}
assert assert10 {
    assertion10
}

/* Assertion 11 -- A class has groups only if it has a teacher assigned */
pred assertion11 {
    inv11
}
assert assert11 {
    assertion11
}

/* Assertion 12 -- Each teacher is responsible for some groups */
pred assertion12 {
    inv12
}
assert assert12 {
    assertion12
}

/* Assertion 13 -- Only teachers tutor and only students are tutored */
pred assertion13 {
    inv13
}
assert assert13 {
    assertion13
}

/* Assertion 14 -- Every student in a class is tutored by all teachers assigned to that class */
pred assertion14 {
    inv14
}
assert assert14 {
    assertion14
}

/* Assertion 15 -- The tutoring chain of every person eventually reaches a Teacher */
pred assertion15 {
    inv15
}
assert assert15 {
    assertion15
}

/* Run all the assertions */
run assert1, assert2, assert3, assert4, assert5, assert6, assert7, assert8, assert9, assert10, assert11, assert12, assert13, assert14, assert15 for 5 */