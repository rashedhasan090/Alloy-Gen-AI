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
    /* Each class has a set of persons assigned to the group. */
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
    all c : Class | lone Teacher & (c -> Teacher) 
}
/* For every class, every student has a group assigned. */
pred inv10 {
    all c : Class, s : Student | some (c -> s -> Group) 
}
/* A class only has groups if it has a teacher assigned. */
pred inv11 {
    all c : Class | some (c -> Group) implies some (Teacher & c.Teaches) 
}
/* Each teacher is responsible for some groups. */
pred inv12 {
    all t : Teacher | some (t -> c -> Group) & (c -> t) & (c -> t.Teaches) 
}
/* Only teachers tutor, and only students are tutored. */
pred inv13 {
    Tutors.Person in Teacher and Person.Tutors in Student 
}
/* Every student in a class is tutored by all teachers assigned to that class. */
pred inv14 {
    all c : Class, s : Student | (s -> c.Groups) in Teacher.Tutors 
}
/* The tutoring chain of every person eventually reaches a teacher. */
pred inv15 {
    all s : Person | some Teacher & ^s.Tutors 
}

/*------ If every assertion is repaired then the model is fixed ------*/
pred MadeFixes() {
    inv1_Repaired[] and inv2_Repaired[] and inv3_Repaired[] and inv4_Repaired[] and inv5_Repaired[] and inv6_Repaired[] and inv7_Repaired[] and inv8_Repaired[] and inv9_Repaired[] and inv10_Repaired[] and inv11_Repaired[] and inv12_Repaired[] and inv13_Repaired[] and inv14_Repaired[] and inv15_Repaired[]
}

/*------ Assert every repair assertion ------*/
assert repair_assert_1{inv1[] iff inv1_OK[] }
assert repair_assert_2{inv2[] iff inv2_OK[] }
assert repair_assert_3{inv3[] iff inv3_OK[] }
assert repair_assert_4{inv4[] iff inv4_OK[] }
assert repair_assert_5{inv5[] iff inv5_OK[] }
assert repair_assert_6{inv6[] iff inv6_OK[] }
assert repair_assert_7{inv7[] iff inv7_OK[] }
assert repair_assert_8{inv8[] iff inv8_OK[] }
assert repair_assert_9{inv9[] iff inv9_OK[] }
assert repair_assert_10{inv10[] iff inv10_OK[] }
assert repair_assert_11{inv11[] iff inv11_OK[] }
assert repair_assert_12{inv12[] iff inv12_OK[] }
assert repair_assert_13{inv13[] iff inv13_OK[] }
assert repair_assert_14{inv14[] iff inv14_OK[] }
assert repair_assert_15{inv15[] iff inv15_OK[] }

/*------ Check all assertions and the model fix ------*/
check MadeFixes() expect 0
check repair_assert_1
check repair_assert_2
check repair_assert_3
check repair_assert_4
check repair_assert_5
check repair_assert_6
check repair_assert_7
check repair_assert_8
check repair_assert_9
check repair_assert_10
check repair_assert_11
check repair_assert_12
check repair_assert_13
check repair_assert_14
check repair_assert_15