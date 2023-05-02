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
	Teacher.Teaches = Class
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
	all c:Class | lone p:Person | p in Teachers.c
}
/* For every class, every student has a group assigned. */
pred inv10 {
  all c:Class, s:Student | some s.(c.Groups)
}
/* A class only has groups if it has a teacher assigned. */
pred inv11 {
	all c : Class | (some c.Groups) implies some t : Teacher | t.Teaches = c
}
/* Each teacher is responsible for some groups. */
pred inv12 {
	all t : Teacher | some cg : t.Teaches.Groups 
}
/* Only teachers tutor, and only students are tutored. */
pred inv13 {
	Tutors.Person in Teacher and Person.Tutors in Student
}
/* Every student in a class is at least tutored by all the teachers
 * assigned to that class. */
pred inv14 {
	all s : Student, c : Class | (some p : Teacher | p.Teaches = c) implies s.(c.Groups) in p.Tutors
}
/* The tutoring chain of every person eventually reaches a Teacher. */
pred inv15 {
	all s : Person | some t : Teacher | t in ^s.Tutors
}

/*===Repaired Preds===*/

pred inv6_2 { Teacher = Teacher.Teaches.Teacher }
pred inv9_2 { all c:Class | lone Teachers.c }
assert fixed_predicates {
    all p:Person | p.inv1 iff p.inv1_2,
    all p:Person | p.inv2 iff p.inv2_2,
    all p:Person | p.inv3 iff p.inv3_2,
    all p:Person | p.inv4 iff p.inv4_2,
    all p:Person | p.inv5 iff p.inv5_2,
    all p:Person | p.inv6 iff p.inv6_2,
    all p:Person | p.inv7 iff p.inv7_2,
    all p:Person | p.inv8 iff p.inv8_2,
    all p:Person | p.inv9 iff p.inv9_2,
    all p:Person | p.inv10 iff p.inv10_2,
    all p:Person | p.inv11 iff p.inv11_2,
    all p:Person | p.inv12 iff p.inv12_2,
    all p:Person | p.inv13 iff p.inv13_2,
    all p:Person | p.inv14 iff p.inv14_2,
    all p:Person | p.inv15 iff p.inv15_2
}

run {
  assert inv1_2
  assert inv2_2
  assert inv3_2
  assert inv4_2
  assert inv5_2
  assert inv6_2
  assert inv7_2
  assert inv8_2
  assert inv9_2
  assert inv10_2
  assert inv11_2
  assert inv12_2
  assert inv13_2
  assert inv14_2
  assert inv15_2
}

/*====Corrected Sig====*/
sig Person  {
	Tutors : set Person,
	Teaches : set Class
}
sig Group {}
sig Class {
	Groups : Person -> Group,
	Teachers : set Teacher
}
sig Teacher extends Person {}
sig Student extends Person {}

/*======Added Preds======*/
pred inv6_2 { Teacher = Teacher.Teaches.Teacher }
pred inv9_2 { all c:Class | lone Teachers.c }
/*==================*/

/*======Repaired Preds======*/

/* Every teacher has classes assigned. */
pred inv6 {
	all t: Teacher | some c: t.Teaches | c in Class
}

/* Every class has teachers assigned. */
pred inv7 {
	all c: Class | some t: c.Teachers
}

/* No class has more than one teacher assigned. */
pred inv9 {
	all c:Class | one t: c.Teachers
}

/* Each teacher is responsible for some groups. */
pred inv12 {
	all t : Teacher | some cg : t.Teaches.Groups 
}

/* A class only has groups if it has a teacher assigned. */
pred inv11 {
	all c : Class | (some c.Groups) implies some t : c.Teachers
}

/* Every student in a class is at least tutored by all the teachers
 * assigned to that class. */
pred inv14 {
	all s : Student, c : Class | (some p : c.Teachers) implies s.(c.Groups) in p.Tutors
}

/* The tutoring chain of every person eventually reaches a Teacher. */
pred inv15 {
	all s : Person | some t : Teacher | t in ^s.Tutors
}

/*=========================*/