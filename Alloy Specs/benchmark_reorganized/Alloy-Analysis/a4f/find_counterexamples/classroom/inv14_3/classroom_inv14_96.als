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
    Person = Student + Teacher
}
/* There are some classes assigned to teachers. */
pred inv5 {
    some c : Class | some t : Teacher | t.Teaches = c 
}
/* Every teacher has classes assigned. */
pred inv6 {
    Teacher.Teaches = Class and Teacher in Teacher.Teaches.Teacher
}
/* Every class has teachers assigned. */
pred inv7 {
    Class.Teacher = Teacher.Teaches and Class in Teacher.Teaches.Class
}
/* Teachers are assigned at most one class. */
pred inv8 {
    all t : Teacher | lone t.Teaches
}
/* No class has more than one teacher assigned. */
pred inv9 {
    all c : Class | lone c.Teacher
}
/* For every class, every student has a group assigned. */
pred inv10 {
    all c : Class, s : Student | some g : Group | (s -> g) in c.Groups
}
/* A class only has groups if it has a teacher assigned. */
pred inv11 {
    all c : Class | (some g : c.Groups | some t : Teacher | t.Teaches = c) implies (some t : Teacher | t.Teaches = c) 
}
/* Each teacher is responsible for some groups. */
pred inv12 {
    all t : Teacher | some c : t.Teaches | some g : Group | (t -> g) in c.Groups
}
/* Only teachers tutor, and only students are tutored. */
pred inv13 {
    Teacher.Tutors = Teacher and Student.Tutors = Student and Teacher.Teaches.Person = Teacher
}
/* Every student in a class is at least tutored by all the teachers assigned to that class. */
pred inv14 {
    all c : Class, s : Student | (s -> c.Groups).Group in c.Groups.Value.Teacher.Tutors
}
/* The tutoring chain of every person eventually reaches a Teacher. */
pred inv15 {
    all s : Student | some t : Teacher | s in t.^Tutors
}
/*======== IFF PERFECT ORACLE ===============*/
pred inv1_OK {
    Person in Student
}
assert inv1_Repaired {
    inv1[] iff inv1_OK[]
}
predicate inv2_OK{
    no Teacher
}
assert inv2_Repaired {
    inv2[] iff inv2_OK[]
}
predicate inv3_OK{
    no Student & Teacher
}
assert inv3_Repaired {
    inv3[] iff inv3_OK[]
}
predicate inv4_OK{
    Person = Student + Teacher
}
assert inv4_Repaired {
    inv4[] iff inv4_OK[]
}
predicate inv5_OK{
    some c : Class | some t : Teacher | t.Teaches = c
}
assert inv5_Repaired {
    inv5[] iff inv5_OK[]
}
predicate inv6_OK{
    Teacher.Teaches = Class and Teacher in Teacher.Teaches.Teacher
}
assert inv6_Repaired {
    inv6[] iff inv6_OK[]
}
predicate inv7_OK{
    Class.Teacher = Teacher.Teaches and Class in Teacher.Teaches.Class
}
assert inv7_Repaired {
    inv7[] iff inv7_OK[]
}
predicate inv8_OK{
    all t : Teacher | lone t.Teaches
}
assert inv8_Repaired {
    inv8[] iff inv8_OK[]
}
predicate inv9_OK{
    all c : Class | lone c.Teacher
}
assert inv9_Repaired {
    inv9[] iff inv9_OK[]
}
predicate inv10_OK{
    all c : Class, s : Student | some g : Group | (s -> g) in c.Groups
}
assert inv10_Repaired {
    inv10[] iff inv10_OK[]
}
predicate inv11_OK{
    all c : Class | (some g : c.Groups | some t : Teacher | t.Teaches = c) implies (some t : Teacher | t.Teaches = c)
}
assert inv11_Repaired {
    inv11[] iff inv11_OK[]
}
predicate inv12_OK{
    all t : Teacher | some c : t.Teaches | some g : Group | (t -> g) in c.Groups
}
assert inv12_Repaired {
    inv12[] iff inv12_OK[]
}
predicate inv13_OK{
    Teacher.Tutors = Teacher and Student.Tutors = Student and Teacher.Teaches.Person = Teacher
}
assert inv13_Repaired {
    inv13[] iff inv13_OK[]
}
predicate inv14_OK{
    all c : Class, s : Student | (s -> c.Groups).Group in c.Groups.Value.Teacher.Tutors
}
assert inv14_Repaired {
    inv14[] iff inv14_OK[]
}
predicate inv15_OK{
    all s : Student | some t : Teacher | s in t.^Tutors
}
assert inv15_Repaired {
    inv15[] iff inv15_OK[]
}
check inv1_Repaired expect 0
check inv2_Repaired expect 0
check inv3_Repaired expect 0 
check inv4_Repaired expect 0
check inv5_Repaired expect 0
check inv6_Repaired expect 0
check inv7_Repaired expect 0
check inv8_Repaired expect 0
check inv9_Repaired expect 0
check inv10_Repaired expect 0
check inv11_Repaired expect 0
check inv12_Repaired expect 0
check inv13_Repaired expect 0
check inv14_Repaired expect 0
check inv15_Repaired expect 0