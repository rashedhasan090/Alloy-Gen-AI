/* The registered persons. */
sig Person {
    /* Each person tutors a set of persons. */
    Tutors: set Person,
    /* Each person teaches a set of classes. */
    Teaches: set Class
}
/* The registered groups. */
sig Group {}
/* The registered classes. */
sig Class {
    /* Each class has a set of persons assigned to a group. */
    Groups: Person -> Group
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
    some t: Teacher | t.Teaches != none
}
/* Every teacher has classes assigned. */
pred inv6 {
    Teacher = Teaches.Person
}
/* Every class has teachers assigned. */
pred inv7 {
    Class = Teacher.Teaches.Class
}
/* Teachers are assigned at most one class. */
pred inv8 {
    all t: Teacher | lone t.Teaches
}
/* No class has more than a teacher assigned. */
pred inv9 {
    all c: Class | lone c.Teaches.Teacher
}
/* For every class, every student has a group assigned. */
pred inv10 {
    all c: Class, s: Student | some g: Group | c.Groups[s] = g
}
/* A class only has groups if it has a teacher assigned. */
pred inv11 {
    all c: Class, g: Group | g in c.Groups.Person.Group implies some t: Teacher | (t,c) in Teaches and (t, Person.g, c) not in Groups
}
/* Each teacher is responsible for some groups. */
pred inv12 {
    all t: Teacher | some g: t.Teaches.Groups
}
/* Only teachers tutor, and only students are tutored. */
pred inv13 {
    Teacher.Tutors = Person.Tutors & Student = Person--Tutors
}
/* Every student in a class is at least tutored by all the teachers
 * assigned to that class. */
pred inv14 {
    all c: Class, s: Student | let tset = c.Teaches.Person | s in c.Groups.Person.Group => s.tutors in tset.Tutors 
}
/* The tutoring chain of every person eventually reaches a Teacher. */
pred inv15 {
    all s: Person | some Teacher & s.(^Tutors)
}
/*======== IFF PERFECT ORACLE ===============*/
pred inv1_OK {
    Person in Student 
}
assert inv1_Repaired {
    inv1[] iff inv1_OK[]
}
predicate repair_pred_2(){
  no t : Teacher | t.Teaches = none
}run repair_pred_2 for 1 assert inv5_Repaired
predicate repair_pred_3(){
  Teacher = Teaches.Person 
}run repair_pred_3 for 1 assert inv6_Repaired
predicate repair_pred_4(){
  Class = Teacher.Teaches.Class
}run repair_pred_4 for 1 assert inv7_Repaired
predicate repair_pred_5(){
 all t: Teacher | lone t.Teaches 
}run repair_pred_5 for 1 assert inv8_Repaired
predicate repair_pred_6(){
  all c: Class | lone c.Teaches.Teacher
}run repair_pred_6 for 1 assert inv9_Repaired
predicate repair_pred_7(){
    all c: Class, s: Student | some g: Group | c.Groups[s] = g
}run repair_pred_7 for 1 assert inv10_Repaired
predicate repair_pred_8(){
 all c: Class, g: Group | g in c.Groups.Person.Group implies some t: Teacher | (t,c) in Teaches and (t, Person.g, c) not in Groups
}run repair_pred_8 for 1 assert inv11_Repaired
predicate repair_pred_9(){
   all t: Teacher | some g: t.Teaches.Groups
}run repair_pred_9 for 1 assert inv12_Repaired
predicate repair_pred_10(){
  Teacher.Tutors = Person.Tutors && Student = Person--Tutors
}run repair_pred_10 for 1 assert inv13_Repaired
predicate repair_pred_11(){
all c: Class, s: Student | let tset = c.Teaches.Person | s in c.Groups.Person.Group => s.tutors in tset.Tutors 
}run repair_pred_11 for 1 assert inv14_Repaired
predicate repair_pred_12(){
all s: Person | some Teacher & s.(^Tutors)
}run repair_pred_12 for 1 assert inv15_Repaired
