/* The registered persons. */
sig Person {
   /* Each person tutors a set of persons. */
   Tutors : set Person,
   /* Each person teaches a set of classes. */
   Teaches: set Class
}

/* The registered groups. */
sig Group{}

/* The registered classes. */
sig Class {
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
   Person in Student + Teacher
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
   Class in Teacher.Teaches
}

/* Teachers are assigned at most one class. */
pred inv8 {
   all t : Teacher | lone t.Teaches
}

/* No class has more than one teacher assigned. */
pred inv9 {
   all c : Class | lone t : Teacher | t -> c in Teaches
}

/* For every class, every student has a group assigned. */
pred inv10 {
   all c : Class, s : Student | some s.(c.Groups)
}

/* A class only has groups if it has a teacher assigned. */
pred inv11 {
   all c : Class | some t : Teacher | t -> c in Teaches implies some g : Group | c.Groups[g]  
}

/* Each teacher is responsible for some groups. */
pred inv12 {
   all t : Teacher | some g : Group, c : Class | t -> c in Teaches and c.Groups[t] = g
}

/* Only teachers tutor, and only students are tutored. */
pred inv13 {
   Tutors.Person in Teacher and Person.Tutors in Student
}

/* Every student in a class is at least tutored by all the teachers
 * assigned to that class. */
pred inv14 {
   all c : Class, s : Student | let Ts = c.Teaches & Teacher |
      s.(c.Groups) in Ts.Tutors
}

/* The tutoring chain of every person eventually reaches a Teacher. */
pred inv15 {
   all s : Person | some t : Teacher | s in t.^Tutors
} 

/* === IFF PerfectOracle === */

assert inv1_repaired {
   inv1[] iff Person in Student
}

assert inv2_repaired {
   inv2[] iff no Teacher
}

assert inv3_repaired {
   inv3[] iff no Student & Teacher
}

assert inv4_repaired {
   inv4[] iff Person in Student + Teacher
}

assert inv5_repaired {
   inv5[] iff some Teacher.Teaches
}

assert inv6_repaired {
   inv6[] iff Teacher.Teaches = Class
}

assert inv7_repaired {
   inv7[] iff Class in Teacher.Teaches
}

assert inv8_repaired {
   inv8[] iff all t : Teacher | lone t.Teaches
}

assert inv9_repaired {
   inv9[] iff all c : Class | lone t : Teacher | t -> c in Teaches
}

assert inv10_repaired {
   inv10[] iff all c : Class, s : Student | some s.(c.Groups)
}

assert inv11_repaired {
   inv11[] iff all c : Class | some t : Teacher | t -> c in Teaches implies some g : Group | c.Groups[g]
}

assert inv12_repaired {
   inv12[] iff all t : Teacher | some g : Group, c : Class | t -> c in Teaches and c.Groups[t] = g
}

assert inv13_repaired {
   inv13[] iff Tutors.Person in Teacher and Person.Tutors in Student
}

assert inv14_repaired {
   inv14[] iff all c : Class, s : Student | let Ts = c.Teaches & Teacher |
      s.(c.Groups) in Ts.Tutors
}

assert inv15_repaired {
   inv15[] iff all s : Person | some t : Teacher | s in t.^Tutors
}

check inv1_repaired
check inv2_repaired
check inv3_repaired
check inv4_repaired
check inv5_repaired
check inv6_repaired
check inv7_repaired
check inv8_repaired
check inv9_repaired
check inv10_repaired
check inv11_repaired
check inv12_repaired
check inv13_repaired
check inv14_repaired
check inv15_repaired