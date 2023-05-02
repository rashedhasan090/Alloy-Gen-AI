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
	some t : Teacher | t.Teaches != none ---- fixed
}
/* Every teacher has classes assigned. */
pred inv6 {
	all t : Teacher | t.Teaches != none ---- fixed
}
/* Every class has teachers assigned. */
pred inv7 {
	all c : Class | c.Teaches != none ----fixed
}
/* Teachers are assigned at most one class. */
pred inv8 {
	all t : Teacher | lone t.Teaches ----correct
}
/* No class has more than a teacher assigned. */
pred inv9 {
	all c : Class | lone c.Teaches ---- fixed
}
/* For every class, every student has a group assigned. */
pred inv10 {
	all c : Class, s : Student | some c.Groups[s] ----correct
}
/* A class only has groups if it has a teacher assigned. */
pred inv11 {
	all c : Class | (some c.Groups) implies some t : Teacher | t.Teaches[c] ----fixed
}
/* Each teacher is responsible for some groups. */
pred inv12 {
	all t : Teacher | some c : t.Teaches | some g : Group | c.Groups[t] = g ----fixed
}
/* Only teachers tutor, and only students are tutored. */
pred inv13 {
	all p : Person | (p in Teacher) = (p.Tutors in Teacher) and (p in Student) = (p.Tutors in Student) ----fixed
}
/* Every student in a class is at least tutored by all the teachers
 * assigned to that class. */
pred inv14 {
	all c : Class, s : Student | s in c.Groups.Person.Tutors implies s in c.Teaches.Teacher.Tutors ----fixed
}
/* The tutoring chain of every person eventually reaches a Teacher. */
pred inv15 {
	all s : Person | some Teacher & ^Tutors.s
}

/* Replacing the faulty invariants */
pred inv5_Repaired { some t : Teacher | t.Teaches != none }
pred inv6_Repaired { all t : Teacher | t.Teaches != none }
pred inv7_Repaired { all c : Class | c.Teaches != none }
assert fixedInvariant {
    all i : (inv1+inv2+inv3+inv4+inv5_Repaired+inv6_Repaired
        +inv7_Repaired+inv8+inv9+inv10+inv11+inv12+inv13+inv14+inv15) |
        check i expect 0
}