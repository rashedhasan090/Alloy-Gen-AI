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
/* There exist classes assigned to teachers. */
pred inv5 {
	some t : Teacher | some c : Class | t in c.Teaches
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
	all t : Teacher | lone t.Teaches 
}
/* No class has more than one teacher assigned. */
pred inv9 {
	all c : Class | lone t : Teacher | t in c.Teaches
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
	all t : Teacher | some c : t.Teaches | some g : Group | g in c.Groups[t]
}
/* Only teachers tutor, and only students are tutored. */
pred inv13 {
	all t : Teacher | t in Tutors
	all s : Student | s in Tutors.Tutors.*
}
/* Every student in a class is at least tutored by all the teachers
 * assigned to that class. */
pred inv14 {
	all c : Class, s : Student |
		let ts = {t : Teacher | t in c.Teaches} |
		s in c.Groups.Tutors.ts
}
/* The tutoring chain of every person eventually reaches a Teacher. */
pred inv15 {
	all s : Student | some t : Teacher | t in ^Tutors.s
}

/* IFF PERFECT ORACLE */
assert inv1_Repaired {
    inv1[] iff Person in Student 
}

assert inv2_Repaired {
    inv2[] iff no Teacher 
}

assert inv3_Repaired {
    inv3[] iff no Student & Teacher 
}

assert inv4_Repaired {
    inv4[] iff Person in (Student + Teacher)
}

assert inv5_Repaired {
    inv5[] iff some t : Teacher | some c : Class | t in c.Teaches
}

assert inv6_Repaired {
    inv6[] iff Teacher in Teaches.Class
}

assert inv7_Repaired {
    inv7[] iff Class in Teacher.Teaches
}

assert inv8_Repaired {
    inv8[] iff all t : Teacher | lone t.Teaches
}

assert inv9_Repaired {
    inv9[] iff all c : Class | lone t : Teacher | t in c.Teaches
}

assert inv10_Repaired {
    inv10[] iff all c : Class, s : Student | some g : Group | g = c.Groups[s]
}

assert inv11_Repaired {
    inv11[] iff all c : Class | (some c.Groups) implies some t : Teacher | t in c.Teaches 
}

assert inv12_Repaired {
    inv12[] iff all t : Teacher | some c : t.Teaches | some g : Group | g in c.Groups[t]
}

assert inv13_Repaired {
    inv13[] iff all t : Teacher | t in Tutors and all s : Student | s in Tutors.Tutors.*
}

assert inv14_Repaired {
    inv14[] iff all c : Class, s : Student |
        let ts = {t : Teacher | t in c.Teaches} |
        s in c.Groups.Tutors.ts
}

assert inv15_Repaired {
    inv15[] iff all s : Student | some t : Teacher | t in ^Tutors.s
}