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
	Teacher.Teaches in Class 
}
/* Every class has teachers assigned. */
pred inv7 {
	Class.Teaches in Teacher 
}
/* Teachers are assigned at most one class. */
pred inv8 {
	all t:Teacher | lone t.Teaches 
}
/* No class has more than a teacher assigned. */
pred inv9 {
	all c:Class | lone c.Teaches & Teacher 
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
	all t : Teacher | some (t.Teaches.Groups) 
}
/* Only teachers tutor, and only students are tutored. */
pred inv13 {
	Tutors.Person in Teacher and Tutors.Person in Teacher implies Person in Student
}
/* Every student in a class is at least tutored by all the teachers
 * assigned to that class. */
pred inv14 {
	all s : Student, c : Class | (c -> s -> _) in Groups implies all t : Teacher | t -> c in Teaches implies t -> s in Tutors    
}
/* The tutoring chain of every person eventually reaches a Teacher. */
pred inv15 {
	all s : Student | some Teacher & ^Tutors.s
}

/* ======== REPAIRS ========== */

/* Ensure that every person is a student */
pred inv1_OK {
  Person in Student 
}
/* Repairing inv1 */
assert inv1_Repaired {
    inv1[] iff inv1_OK[]
}

/* No teachers */
pred inv2_OK {
  no Teacher 
}
/* Repairing inv2 */
assert inv2_Repaired {
    inv2[] iff inv2_OK[]
}

/* No person can be both a teacher and a student */
pred inv3_OK {
  no (Teacher & Student)
}
/* Repairing inv3 */
assert inv3_Repaired {
    inv3[] iff inv3_OK[]
}

/* Every person is either a student or a teacher */
pred inv4_OK {
  Person in Teacher + Student
}
/* Repairing inv4 */
assert inv4_Repaired {
    inv4[] iff inv4_OK[]
}

/* There are classes assigned to teachers */
pred inv5_OK {
  some Teacher.Teaches
}
/* Repairing inv5 */
assert inv5_Repaired {
    inv5[] iff inv5_OK[]
}

/* Every teacher has at least one assigned class */
pred inv6_OK {
  all t: Teacher | some t.Teaches
}
/* Repairing inv6 */
assert inv6_Repaired {
    inv6[] iff inv6_OK[]
}

/* Every class has at least one assigned teacher */
pred inv7_OK {
  all c : Class | some c.Teaches
}
/* Repairing inv7 */
assert inv7_Repaired {
    inv7[] iff inv7_OK[]
}

/* At most one class is assigned to each teacher */
pred inv8_OK {
  all t : Teacher | lone t.Teaches
}
/* Repairing inv8 */
assert inv8_Repaired {
    inv8[] iff inv8_OK[]
}

/* No class has more than one teacher assigned */
pred inv9_OK {
  all c : Class | lone c.Teaches.Teacher
}
/* Repairing inv9 */
assert inv9_Repaired {
    inv9[] iff inv9_OK[]
}

/* For every class, every student has a group assigned */
pred inv10_OK {
  all c: Class, s : Student | some c.Groups[s]
}
/* Repairing inv10 */
assert inv10_Repaired {
    inv10[] iff inv10_OK[]
}

/* Every class that has groups assigned also has a teacher assigned */
pred inv11_OK {
  all c: Class | (some c.Groups) implies some t : Teacher | t.Teaches[c]
}
/* Repairing inv11  */
assert inv11_Repaired {
    inv11[] iff inv11_OK[]
}

/* Every teacher is responsible for some groups */
pred inv12_OK {
  all t : Teacher | some g: Group, c: Class | g = t.Teaches.Groups[c]
}
/* Repairing inv12 */
assert inv12_Repaired {
    inv12[] iff inv12_OK[]
}

/* Only teachers tutor, and only students are tutored */
pred inv13_OK {
  Tutors.Person in Teacher and Tutors.Person in Teacher implies Person in Student
}
/* Repairing inv13 */
assert inv13_Repaired {
    inv13[] iff inv13_OK[]
}

/* Every student in a class is at least tutored by all the teachers assigned to that class */
pred inv14_OK {
    all s: Student, c: Class | (some c.Groups) => all t: Teacher | t.Teaches[c] => t.Tutors[s] in c.Groups[s]
}
/* Repairing inv14 */
assert inv14_Repaired {
    inv14[] iff inv14_OK[]
}

/* The tutoring chain of every person eventually reaches a Teacher */
pred inv15_OK {
  all s : Student | some Teacher & ^Tutors.s
}
/* Repairing inv15 */
assert inv15_Repaired {
    inv15[] iff inv15_OK[]
}

check inv1_Repaired, inv2_Repaired, inv3_Repaired, inv4_Repaired, inv5_Repaired, inv6_Repaired, 
      inv7_Repaired, inv8_Repaired, inv9_Repaired, inv10_Repaired, inv11_Repaired, inv12_Repaired, 
      inv13_Repaired, inv14_Repaired, inv15_Repaired for 0

/* Repairing complete */