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
/* No class has more than one teacher assigned. */
pred inv9 {
    all c:Class | lone t: Teacher | t -> c in Teaches 
}
/* For every class, every student has a group assigned. */
pred inv10 {
    all c:Class, s:Student | some s.(c.Groups) 
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

/* FIXED PREDICATE ASSERTIONS */
pred inv8_OK {
    all t:Teacher | lone t.Teaches 
}
assert inv8_Repaired {
    inv8[] iff inv8_OK[]
}

pred repair_pred_1 {
    inv8[] iff inv8_OK[]
}
run repair_pred_1
assert repair_assert_1 {
    inv8[] iff inv8_OK[]
}

/* VERIFYING INTEGRITY OF ALL ASSERTIONS AND REPAIRS */
---- check original predicates
check inv1 expect 0
check inv2 expect 1
check inv3 expect 0
check inv4 expect 0
check inv5 expect 1
check inv6 expect 1
check inv7 expect 1
check inv8 expect 0
check inv9 expect 0
check inv10 expect 1
check inv11 expect 1
check inv12 expect 1
check inv13 expect 1
check inv14 expect 0
check inv15 expect 1

---- check repaired predicates
check inv1_Repaired expect 1
check inv2_Repaired expect 1
check inv3_Repaired expect 1 
check inv4_Repaired expect 1
check inv5_Repaired expect 1
check inv6_Repaired expect 1
check inv7_Repaired expect 1
check inv8_Repaired expect 1
check inv9_Repaired expect 1
check inv10_Repaired expect 1
check inv11_Repaired expect 1
check inv12_Repaired expect 1
check inv13_Repaired expect 1
check inv14_Repaired expect 1
check inv15_Repaired expect 1

---- check repairs
check repair_assert_1 expect 1