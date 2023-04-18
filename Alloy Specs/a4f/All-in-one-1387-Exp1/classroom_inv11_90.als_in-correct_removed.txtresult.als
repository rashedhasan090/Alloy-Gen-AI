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
    Groups : Person -> Group,
    /* Each class has a set of teachers. */
    Teachers : set Teacher
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

/* Some teachers teach classes. */
pred inv5 {
    some Teacher.Teaches
}

/* Every teacher has classes assigned. */
pred inv6 {
    Teacher.Teaches = Teaches & Teacher
}

/* Every class has teachers assigned. */
pred inv7 {
    Class.Teachers = Teacher & Teaches.Class
}

/* Teachers are assigned at most one class. */
pred inv8 {
    all t:Teacher | lone t.Teaches
}

/* No class has more than one teacher assigned. */
pred inv9 {
    all c:Class | lone c.Teachers
}

/* For every class, every student has a group assigned. */
pred inv10 {
    all c:Class, s:Student | some s.(c.Groups)
}

/* A class only has groups if it has a teacher assigned. */
pred inv11 {
    all c : Class | (some c.Groups) implies some c.Teachers
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

/* Relevance of all predicates according to the specification, i.e., all predicates should have zero errors*/
assert PerfectOracle{
    inv1 and inv2 and inv3 and inv4 and inv5 and inv6 and inv7 and inv8 and inv9 and inv10 and inv11 and inv12 and inv13 and inv14 and inv15
}

/* Repaired predicates */
pred inv1_OK {
    Person in Student
}

pred inv2_OK {
    no Teacher
}

pred inv3_OK {
    no Student & Teacher
}

pred inv4_OK {
    Person in (Student + Teacher)
}

pred inv5_OK {
    some Teacher.Teaches
}

pred inv6_OK {
    Teacher in Teaches.Class
}

pred inv7_OK {
    Class in Teacher.Teaches
}

pred inv8_OK {
    all t:Teacher | lone t.Teaches
}

pred inv9_OK {
    all c:Class | lone c.Teachers
}

pred inv10_OK {
    all c:Class, s:Student | some s.(c.Groups)
}

pred inv11_OK {
    all c : Class | (some c.Groups) implies some c.Teachers
}

pred inv12_OK {
    all t : Teacher | some (t.Teaches).Groups
}

pred inv13_OK {
    Tutors.Person in Teacher and Person.Tutors in Student
}

pred inv14_OK {
    all s : Person, c : Class, t : Person, g : Group | (c -> s -> g in Groups) and t -> c in Teaches implies t -> s in Tutors
}

pred inv15_OK {
    all s : Person | some Teacher & ^Tutors.s
}

/* Relevance of all repaired predicates according to the specification*/
assert PerfectOracle_Repaired{
    inv1_OK and inv2_OK and inv3_OK and inv4_OK and inv5_OK and inv6_OK and inv7_OK and inv8_OK and inv9_OK and inv10_OK and inv11_OK and inv12_OK and inv13_OK and inv14_OK and inv15_OK
}

/* Compares all original predicates with their repaired versions*/
run comparison {all i: (int 1..15) | PerfectOracle.i iff PerfectOracle_Repaired.i}

/* Runs the all the repaired predicates and perfect oracles */
check PerfectOracle_Repaired
check PerfectOracle expect 0
check inv1_OK expect 0
check inv2_OK expect 0
check inv3_OK expect 0 
check inv4_OK expect 0
check inv5_OK expect 0
check inv6_OK expect 0
check inv7_OK expect 0
check inv8_OK expect 0
check inv9_OK expect 0
check inv10_OK expect 0
check inv11_OK expect 0
check inv12_OK expect 0
check inv13_OK expect 0
check inv14_OK expect 0
check inv15_OK expect 0