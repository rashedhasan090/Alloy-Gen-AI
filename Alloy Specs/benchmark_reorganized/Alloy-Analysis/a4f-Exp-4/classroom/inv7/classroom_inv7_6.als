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
    some Teacher.Teaches 
}
/* Every teacher has classes assigned. */
pred inv6 {
    Teacher.Teaches = Class 
}
/* Every class has teachers assigned. */
pred inv7 {
    all c : Class | c.Teaches in Teacher 
}
/* Teachers are assigned at most one class. */
pred inv8 {
    all t:Teacher | #t.Teaches <= 1 
}
/* No class has more than a teacher assigned. */
pred inv9 {
    all c:Class | lone c.Teaches.Teacher 
}
/* For every class, every student has a group assigned. */
pred inv10 {
    all c:Class, s:Student | some g:Group | c.Groups[s] = g 
}
/* A class only has groups if it has a teacher assigned. */
pred inv11 {
    all c : Class | (some c.Groups) implies some t : Teacher | t.Teaches = c 
}
/* Each teacher is responsible for some groups. */
pred inv12 {
    all t : Teacher | some c : t.Teaches | some g : Group | c.Groups[t] = g 
}
/* Only teachers tutor, and only students are tutored. */
pred inv13 {
    all p : Person | (p in Teacher) = (p.Tutors in Teacher) and (p in Student) = (p.Tutors in Student) 
}
/* Every student in a class is at least tutored by all the teachers
 * assigned to that class. */
pred inv14 {
    all c : Class, s : Student | (some c.Groups[s]) implies all t : c.Teaches.Teacher | s in t.Tutors 
}
/* The tutoring chain of every person eventually reaches a Teacher. */
pred inv15 {
    all s : Person | some t : Teacher | s in t.^Tutors 
}

/*====== IFF PERFECT ORACLE ======*/

pred all_ok{
    inv1_OK and inv2_OK and inv3_OK and inv4_OK and inv5_OK and inv6_OK and inv7_OK and inv8_OK and inv9_OK and inv10_OK and inv11_OK and inv12_OK and inv13_OK and inv14_OK and inv15_OK
}

assert repaired_assertion{
    all_ok
}

check repaired_assertion expect 0