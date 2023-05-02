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
	Student in Person
}
/* There are no teachers. */
pred inv2 {
	no Teacher
}
/* No person is both a student and a teacher. */
pred inv3 {
	no (Student & Teacher)
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
	Class.teachers = Teacher
}
/* Teachers are assigned at most one class. */
pred inv8 {
	all t:Teacher | lone t.Teaches
}
/* No class has more than one teacher assigned. */
pred inv9 {
	all c:Class | lone c.teachers
}
/* For every class, every student has a group assigned. */
pred inv10 {
	all c:Class, s:Student | some c.Groups[s]
}
/* A class only has groups if it has a teacher assigned. */
pred inv11 {
	all c : Class | (some c.Groups) implies some Teacher & c.teachers
}
/* Each teacher is responsible for some groups. */
pred inv12 {
	all t : Teacher | some c : t.Teaches | some g : Group | c.Groups[t] = g
}
/* Only teachers tutor, and only students are tutored. */
pred inv13 {
	Tutor = Teacher & Student = ~Tutor
}
/* Every student in a class is at least tutored by all the teachers
 * assigned to that class. */
pred inv14 {
	all s : Student, c : Class | s in c.Groups.Person.Tutors.Teacher.Teaches implies c.teachers.tutors.s
}
/* The tutoring chain of every person eventually reaches a Teacher. */
pred inv15 {
	all s : Person | some Teacher & ^s.Tutors
}
/* the invariant checking */
assert Invariants {
	all p: Person | p in Teacher or p in Student
  //invariant previously known as inv1
  Student in Person
  //invariant previously known as inv2
  no Teacher
  //invariant previously known as inv3
  no (Student & Teacher)
  //invariant previously known as inv4
  Person = Student + Teacher
  //invariant previously known as inv5
  some Teacher.Teaches
  //invariant previously known as inv6
  Teacher.Teaches = Class
  //invariant previously known as inv7
  Class.teachers = Teacher
  //invariant previously known as inv8
  all t:Teacher | lone t.Teaches
  //invariant previously known as inv9
  all c:Class | lone c.teachers
  //invariant previously known as inv10
  all c:Class, s:Student | some c.Groups[s]
  //invariant previously known as inv11
  all c : Class | (some c.Groups) implies some Teacher & c.teachers
  //invariant previously known as inv12
  all t : Teacher | some c : t.Teaches | some g : Group | c.Groups[t] = g
  //invariant previously known as inv13
  Tutor = Teacher & Student = ~Tutor
  //invariant previously known as inv14
  all s : Student, c : Class | s in c.Groups.Person.Tutors.Teacher.Teaches implies c.teachers.tutors.s
  //invariant previously known as inv15
  all s : Person | some Teacher & ^s.Tutors
}
/* the command for checking invariant */
check Invariants for 5
/* the command for finding counter example */
run Invariants for 5 but 7 Person
/* The counterexample found by Alloy for this example is due to the fact that the predicate inv14 is too strict. It may not work for cases where there are some exceptional students who are not tutored by all the teachers that are teaching in a class. This can happen if some students have opted not to be tutored for some reasons.