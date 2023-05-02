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
	some c : Class | some t : Teacher  |  t.Teaches = c 
}
/* Every teacher has classes assigned. */
pred inv6 {
	all t : Teacher | some c : t.Teaches | c.Teacher = t
}
/* Every class has teachers assigned. */
pred inv7 {
	all c : Class | some t : Teacher | t.Teaches = c 
}
/* Teachers are assigned at most one class. */
pred inv8 {
	all t : Teacher | #t.Teaches <= 1
}
/* No class has more than a teacher assigned. */
pred inv9 {
	all c : Class | #c.Teaches <= 1
}
/* For every class, every student has a group assigned. */
pred inv10 {
	all c : Class, s : Student |
		s in c.Groups.Person
}
/* A class only has groups if it has a teacher assigned. */
pred inv11 {
	all c : Class |
		(some g : c.Groups | some t : c.Teacher | g.t = c)
		implies
		(some t : c.Teacher)
}
/* Each teacher is responsible for some groups. */
pred inv12 {
	all t : Teacher |
		(some c : t.Teaches | some g : c.Groups | g.t = t)
}
/* Only teachers tutor, and only students are tutored. */
pred inv13 {
	all p : Person |
		(p in Teacher) = (p.Tutors != {})
		(p in Student) = (p.Tutors != none)
}
/* Every student in a class is at least tutored by all the teachers
 * assigned to that class. */
pred inv14 {
	all c : Class, g : c.Groups, s : g.Person |
		all t : c.Teacher |
			s in t.Tutors
}
/* The tutoring chain of every person eventually reaches a Teacher. */
pred inv15 {
	all p : Person |
		(some t : Teacher |
			t in ^p.Tutors)
}

/* IFF PERFECT ORACLE */
pred perfect_oracle {
	inv1 and inv2 and inv3 and inv4 and inv5 and inv6 and inv7 and inv8 and inv9 and inv10 and inv11 and inv12 and inv13 and inv14 and inv15
}

check perfect_oracle expect 0