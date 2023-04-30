/* Fixed code: */
/* The registered persons. */
sig Person  {
    /* Each person tutors a set of persons. */
    Tutors : set Person,
    /* Each person teaches a set of classes. */
    Teaches : set Class,
    /* Every person is a student. */
    inStudent: one Bool //New field to fix the bug
}
/* The registered groups. */
sig Group {}
/* The registered classes. */
sig Class  {
    /* Each class has a set of persons assigned to a group. */
    Groups : Person -> Group
}
/* Some persons are teachers. */
sig Teacher extends Person {
   /* Every teacher is a teacher */
    inTeacher: one Bool
}
/* Some persons are students. */
sig Student extends Person {
    /* Every student is a student */
    inStudent: one Bool
}
/* Registration Constraints */
fact registrationConstraints {
    /* Every person is a student. */
    all p: Person | p.inStudent = (p in Student)
    /* Every teacher is a teacher. */
    all t: Teacher | t.inTeacher = (t in Teacher)
    /* No person is both a student and a teacher. */
    no Student & Teacher
    /* No person is neither a student nor a teacher. */
    all p: Person | p.inStudent = (p in Student) or p.inTeacher = (p in Teacher)
    }

/* Invariants */
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
/* No class has more than a teacher assigned. */
pred inv9 {
    all c: Class | lone (Teaches.c & Teacher)
}
/* For every class, every student has a group assigned. */
pred inv10 {
    all c: Class, s: Student | some s.(c.Groups) 
}
/* A class only has groups if it has a teacher assigned. */
pred inv11 {
    all c : Class | (some c.Groups) implies some Teacher & Teaches.c 
}
/* Each teacher is responsible for some groups. */
pred inv12 {
    all t : Teacher | some (t.Teaches).Groups 
}
/* Only teachers tutor, and only students are tutored. */
pred inv13 {
    Tutors.Person in Teacher and Person.Tutors in Student 
}
/* Every student in a class is at least tutored by all the teachers
* assigned to that class. */
pred inv14 {
    all s : Person, c : Class, t : Person, g : Group | (c -> s -> g in Groups) and t -> c in Teaches implies t -> s in Tutors
}
/* The tutoring chain of every person eventually reaches a Teacher. */
pred inv15 {
    all s : Person | some Teacher & ^Tutors.s
}
/* Assertions*/
asserts assert1 {
    all c: in Class | all s: in Student | all t: in Teacher | all g: in Group |
    (c -> s -> g in Groups) and t -> c in Teaches => t -> s in Tutors
}
asserts assert2 {
    all c: in Class | all s: in Student | some g: in Group | (c -> s -> g in Groups)
}
asserts assert3 {
    all c: in Class | some t: in Teacher | t -> c in Teaches
}
asserts assert4 {
    all t: in Teacher | some c: in Class | t -> c in Teaches
}
asserts assert5 {
    all s1, s2: in Student | s1 != s2 => some t: in Teacher | t -> s1 in Tutors and t -> s2 in Tutors 
}
asserts assert6 {
    all t1, t2: in Teacher | t1 != t2 => some s: in Student | t1 -> s in Tutors and t2 -> s in Tutors
}
asserts assert7 {
    all s: in Student | some t: in Teacher | t -> s in Tutors
}
/* Confirmation that all the assertions are true */
run {
    all a: asserts | check a
}

/* Check for invalidated predicates */
run {
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
}