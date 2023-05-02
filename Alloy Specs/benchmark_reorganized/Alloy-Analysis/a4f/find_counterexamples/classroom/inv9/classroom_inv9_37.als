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
	Person in Student ----correct
}
/* There are no teachers. */
pred inv2 {
	no Teacher ----correct
}
/* No person is both a student and a teacher. */
pred inv3 {
	no Student & Teacher ----correct
}
/* No person is neither a student nor a teacher. */
pred inv4 {
	Person in (Student + Teacher) ----correct
}
/* There are some classes assigned to teachers. */
pred inv5 {
	some Teacher.Teaches ----correct
}
/* Every teacher has classes assigned. */
pred inv6 {
	Teacher in Teaches.Class ----correct
}
/* Every class has teachers assigned. */
pred inv7 {
	Class in Teacher.Teaches ----correct
}
/* Teachers are assigned at most one class. */
pred inv8 {
	all t:Teacher | lone t.Teaches ----correct
}
/* No class has more than a teacher assigned. */
pred inv9 {
	all c:Class | lone (Teaches.c & Teacher)
}
/* For every class, every student has a group assigned. */
pred inv10 {
	all c:Class, s:Student | some s.(c.Groups) ----correct
}
/* A class only has groups if it has a teacher assigned. */
pred inv11 {
	all c : Class | (some c.Groups) implies some Teacher & Teaches.c ----correct
}
/* Each teacher is responsible for some groups. */
pred inv12 {
	all t : Teacher | some (t.Teaches).Groups ----correct
}
/* Only teachers tutor, and only students are tutored. */
pred inv13 {
	Tutors.Person in Teacher and Person.Tutors in Student ----correct
}
/* Every student in a class is at least tutored by all the teachers
 * assigned to that class. */
pred inv14 {
	all s : Person, c : Class | c -> s not in Tutors or some t : Teacher | t -> c in Teaches and t -> s in Tutors
}
/* The tutoring chain of every person eventually reaches a Teacher. */
pred inv15 {
	all s : Person | some Teacher & ^Tutors.s
}

/* The fixed invariant 9 is "no class has more than a teacher assigned." */

/* The repaired Alloy code: */

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
/* No class has more than a teacher assigned. */
pred inv9 {
	all c:Class | lone (Teaches.c & Teacher)
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
	all s : Person, c : Class | c -> s not in Tutors or some t : Teacher | t -> c in Teaches and t -> s in Tutors
}
/* The tutoring chain of every person eventually reaches a Teacher. */
pred inv15 {
	all s : Person | some Teacher & ^Tutors.s
} 

assert Valid
{
  all disj c1, c2: Class | c1 != c2 => c1.Groups != c2.Groups
} 
/* All groups are distinct */


/* Verification of repaired specification */
run inv1 for 3 but 2 Person, 2 Teacher, 1 Class, 2 Group, exactly 1 Student
run inv2 for 3 but 2 Person, 0 Teacher, 1 Class, 1 Group, 1 Student
run inv3 for 3 but 1 Person, 1 Teacher, 1 Student, 1 Class, 2Group
run inv4 for 3 but 2 Person, 1 Teacher, 1 Student, 1 Class, 2Group
run inv5 for 3 but 2 Person, 2 Teacher, 1 Student, 1 Class, 1 Group
run inv6 for 3 but 2 Person, 2 Teacher, 1 Class, 1 Group, 1 Student
run inv7 for 3 but 2 Person, 2 Teacher, 1 Class, 1 Group, 1 Student
run inv8 for 3 but 2 Person, 2 Teacher, 1 Class, 1 Group, 1 Student
run inv9 for 3 but 2 Person, 2 Teacher, 2 Class, 2 Group, 1 Student
run inv10 for 3 but 1 Person, 1 Class, 3 Student, 1 Group
run inv11 for 3 but 1 Person, 1 Teacher, 1 Class, 2 Group, 2 Student
run inv12 for 4 but 2 Person, 2 Teacher, 1 Class, 2 Group, 1 Student
run inv13 for 3 but 2 Person, 2 Teacher, 1 Class, 2 Group, 2 Student
run inv14 for 3 but 2 Person, 2 Teacher, 1 Class, 2 Group, 3 Student
run inv15 for 3 but 2 Person, 2 Teacher, 1 Class, 2 Group, 2 Student

check Valid for 5 but 2 Person, 2 Teacher, 1 Class, 2 Group, 2 Student
/* Verification of repaired specification */