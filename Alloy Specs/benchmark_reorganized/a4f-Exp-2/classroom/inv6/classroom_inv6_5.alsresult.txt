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
    Person in (Student + Teacher) 
}
/* There are some classes assigned to teachers. */
pred inv5 {
    some Teacher.Teaches 
}
/* Every teacher has classes assigned. */
pred inv6 {
    all t:Teacher | t.Teaches in Class implies t in Teaching 
}
/* Every class has teachers assigned. */
pred inv7 {
    all c:Class | c.Teacher in Teacher.Teaches 
}
/* Teachers are assigned at most one class. */
pred inv8 {
    all t:Teacher | lone t.Teaches 
}
/* No class has more than a teacher assigned. */
pred inv9 {
    all c:Class | lone c.Teacher
}
/* For every class, every student has a group assigned. */
pred inv10 {
    all c:Class, s:Student | some g:Group | (s->g) in c.Groups 
}
/* A class only has groups if it has a teacher assigned. */
pred inv11 {
    all c:Class | (some c.Groups) implies some t:Teacher | c.Teacher = t and t in c.Teaches
}
/* Each teacher is responsible for some groups. */
pred inv12 {
    all t:Teacher | some c:Class, g:Group | (t->c) in Teaches and (c->(t->g)) in Groups 
}
/* Only teachers tutor, and only students are tutored. */
pred inv13 {
    Tutors.Person in Teacher and Person.Tutors in Student 
}
/* Every student in a class is at least tutored by all the teachers
* assigned to that class. */
pred inv14 {
    all c:Class, s:Student | let tset = c.Teacher.Teaches | (s->tset) in Tutors 
}
/* The tutoring chain of every person eventually reaches a Teacher. */
pred inv15 {
    all s:Person | some t:Teacher | s in t.^Tutors 
}

/* =============================================== */

/* Perfect oracle commands */

pred inv1_fixed {
    Person in Student
}

assert inv1_repaired {
    inv1 iff inv1_fixed
}

pred inv2_fixed {
    no Teacher
}

assert inv2_repaired {
    inv2 iff inv2_fixed
}

pred inv3_fixed {
    no Student & Teacher
}

assert inv3_repaired {
    inv3 iff inv3_fixed
}

pred inv4_fixed {
    Person in (Teacher + Student)
}

assert inv4_repaired {
    inv4 iff inv4_fixed
}

pred inv5_fixed {
    some Teacher.Teaches
}

assert inv5_repaired {
    inv5 iff inv5_fixed
}

pred inv6_fixed {
    all t:Teacher | (t.Teaches != none) implies t in Teaching
}

assert inv6_repaired {
    inv6 iff inv6_fixed
}

pred inv7_fixed {
    all c:Class | c.Teacher.Teaches in Teacher
}

assert inv7_repaired {
    inv7 iff inv7_fixed
}

pred inv8_fixed {
    all t:Teacher | lone t.Teaches
}

assert inv8_repaired {
    inv8 iff inv8_fixed
}

pred inv9_fixed {
    all c:Class | lone c.Teacher
}

assert inv9_repaired {
    inv9 iff inv9_fixed
}

pred inv10_fixed {
    all c:Class, s:Student | (s -> c.Groups) != none
}

assert inv10_repaired {
    inv10 iff inv10_fixed
}

pred inv11_fixed {
    all c:Class, g:Group | (some c.Groups.g implies some t:Teacher | t in c.Teaches and c.Teacher = t)
}

assert inv11_repaired {
    inv11 iff inv11_fixed
}

pred inv12_fixed {
    all t:Teacher | some c:Class, g:Group | (t -> c) in Teaches and (c -> (t -> g)) in Groups
}

assert inv12_repaired {
    inv12 iff inv12_fixed
}

pred inv13_fixed {
    all p:Person | (p in Teacher implies p.Tutors in Teacher) && (p in Student implies p.Tutors in Student)
}

assert inv13_repaired {
    inv13 iff inv13_fixed
}

pred inv14_fixed {
    all c:Class, s:Student | (s -> c.Groups) != none implies (s.Tutors & c.Teacher.Teaches) != none
}

assert inv14_repaired {
    inv14 iff inv14_fixed
}

pred inv15_fixed {
    all s:Person | s.Tutors != none implies (some t:Teacher | s in t.^Tutors)
}

assert inv15_repaired {
    inv15 iff inv15_fixed
}

/* =============================================== */

/* Validation */

check inv1_repaired expect 0
check inv2_repaired expect 0
check inv3_repaired expect 0
check inv4_repaired expect 0
check inv5_repaired expect 0
check inv6_repaired expect 0
check inv7_repaired expect 0
check inv8_repaired expect 0
check inv9_repaired expect 0
check inv10_repaired expect 0
check inv11_repaired expect 0
check inv12_repaired expect 0
check inv13_repaired expect 0
check inv14_repaired expect 0
check inv15_repaired expect 0