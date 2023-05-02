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
/* No class has more than one teacher assigned. */
pred inv9 {
	all c:Class | lone t: Teacher | t in c.Teaches
}
/* For every class, every student has a group assigned. */
pred inv10 {
	all c:Class, s:Student | some (c.Groups).s
}
/* A class only has non--empty groups if it has a teacher assigned. */
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
	all c:Class, s:Student | some t:Teacher | t in c.Teaches implies t -> s in Tutors
}
/* The tutoring chain of every person eventually reaches a Teacher. */
pred inv15 {
	all s : Person | some Teacher & ^Tutors.s
}

/* IFF PERFECT ORACLE */
// Repaired invariant 1
pred inv1Repaired {
    Person in Student
}
assert inv1Fixed {
    inv1[] iff inv1Repaired[]
}

// Repaired invariant 2
pred inv2Repaired {
    Teacher !in Person
}
assert inv2Fixed {
    inv2[] iff inv2Repaired[]
}

// Repaired invariant 3
pred inv3Repaired {
    disjoint[Student, Teacher]
}
assert inv3Fixed {
    inv3[] iff inv3Repaired[]
}

// Repaired invariant 4
pred inv4Repaired {
    Person = Student + Teacher
}
assert inv4Fixed {
    inv4[] iff inv4Repaired[]
}

// Repaired invariant 5
pred inv5Repaired {
    some t : Teacher | t.Teaches != none
}
assert inv5Fixed {
    inv5[] iff inv5Repaired[]
}

// Repaired invariant 6
pred inv6Repaired {
    all t : Teacher | t.Teaches in Class and t in Teaches.Class
}
assert inv6Fixed {
    inv6[] iff inv6Repaired[]
}

// Repaired invariant 7
pred inv7Repaired {
    all c : Class | c in Teacher.Teaches
}
assert inv7Fixed {
    inv7[] iff inv7Repaired[]
}

// Repaired invariant 8
pred inv8Repaired {
    all t : Teacher | lone t.Teaches
}
assert inv8Fixed {
    inv8[] iff inv8Repaired[]
}

// Repaired invariant 9
pred inv9Repaired {
    all c : Class | lone t : Teacher | t in c.Teaches
}
assert inv9Fixed {
    inv9[] iff inv9Repaired[]
}

// Repaired invariant 10
pred inv10Repaired {
    all c : Class, s : Student | some g : Group | g in c.Groups.s
}
assert inv10Fixed {
    inv10[] iff inv10Repaired[]
}

// Repaired invariant 11
pred inv11Repaired {
    all c : Class | no c.Groups => no c.Teaches
}
assert inv11Fixed {
    inv11[] iff inv11Repaired[]
}

// Repaired invariant 12
pred inv12Repaired {
    all t : Teacher | some t.Teaches.Groups
}
assert inv12Fixed {
    inv12[] iff inv12Repaired[]
}

// Repaired invariant 13
pred inv13Repaired {
    all t : Teacher, s : Student | t in s.Tutors.Person and s in t.Tutors.Student
}
assert inv13Fixed {
    inv13[] iff inv13Repaired[]
}

// Repaired invariant 14
pred inv14Repaired {
    all c : Class, s : Student |
        all t : Teacher |
            t in c.Teaches and t -> s in Tutors => some g : Group | g in c.Groups.s
}
assert inv14Fixed {
    inv14[] iff inv14Repaired[]
}

// Repaired invariant 15
pred inv15Repaired {
    all p : Person | p in Teacher =>
        some Teacher & ^Tutors.p or p in Student => some Teacher & ^Tutors.p
}
assert inv15Fixed {
    inv15[] iff inv15Repaired[]
}

// Check all the invariants
check inv1Fixed
check inv2Fixed
check inv3Fixed
check inv4Fixed
check inv5Fixed
check inv6Fixed
check inv7Fixed
check inv8Fixed
check inv9Fixed
check inv10Fixed
check inv11Fixed
check inv12Fixed
check inv13Fixed
check inv14Fixed
check inv15Fixed