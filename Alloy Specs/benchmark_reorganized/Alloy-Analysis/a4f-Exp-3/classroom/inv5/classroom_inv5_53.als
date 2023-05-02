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
	Groups : Person lone-> Group
	/* using `lone` instead of `->` ensures that each person in Groups is assigned to only one group */
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
	all t : Teacher | some c : Class | c in t.Teaches 
}
/* Every class has teachers assigned. */
pred inv7 {
	all c : Class | some t : Teacher | t in c.Teaches 
}
/* Teachers are assigned at most one class. */
pred inv8 {
	all t : Teacher | lone t.Teaches 
}
/* No class has more than one teacher assigned. */
pred inv9 {
	no c : Class | #Teaches.c > 1 
}
/* For every class, every student has a group assigned. */
pred inv10 {
	all c : Class, s : Student | some g : Group | g = c.Groups[s]
}
/* A class only has groups if it has a teacher assigned. */
pred inv11 {
	all c : Class | (some c.Groups) implies some t : Teacher | t in c.Teaches
}
/* Each teacher is responsible for some groups. */
pred inv12 {
	all t : Teacher | some g : Group | some c : t.Teaches | g = c.Groups[t]
}
/* Only teachers tutor, and only students are tutored. */
pred inv13 {
	all t : Teacher, s : Student |
		t.Tutors = {} and s.Tutors != {} or
		t in s.Tutors
}
/* Every student in a class is at least tutored by all the teachers
 * assigned to that class. */
pred inv14 {
	all c : Class, s : Student |
		all t : c.Teaches.Teacher |
			s in t.Tutors implies s in c.Groups[t] 
}
/* The tutoring chain of every person eventually reaches a Teacher. */
pred inv15 {
	all s : Student | some t : Teacher | s in t.^Tutors
}

run {
	/* check that all repaired invariants hold */
	assert inv5_Repaired { some Teacher.Teaches }
	assert inv6_Repaired { all t : Teacher | some c : Class | c in t.Teaches }
	assert inv7_Repaired { all c : Class | some t : Teacher | t in c.Teaches }
	assert inv8_Repaired { all t : Teacher | lone t.Teaches }
	assert inv9_Repaired { no c : Class | #Teaches.c > 1 }
	assert inv10_Repaired { all c : Class, s : Student | some g : Group | g = c.Groups[s] }
	assert inv11_Repaired { all c : Class | (some c.Groups) implies some t : Teacher | t in c.Teaches }
	assert inv12_Repaired { all t : Teacher | some g : Group | some c : t.Teaches | g = c.Groups[t] }
	assert inv13_Repaired { all t : Teacher, s : Student |
			t.Tutors = {} and s.Tutors != {} or
			t in s.Tutors }
	assert inv14_Repaired { all c : Class, s : Student |
			all t : c.Teaches.Teacher |
				s in t.Tutors implies s in c.Groups[t] }
	assert inv15_Repaired { all s : Student | some t : Teacher | s in t.^Tutors }
} for 5    ---- set example scope to 5 to ensure enough instances are generated for the predicates to be checked accurately. 
