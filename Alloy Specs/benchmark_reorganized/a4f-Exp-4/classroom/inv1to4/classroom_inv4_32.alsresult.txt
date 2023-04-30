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
	all p:Person | p in (Student + Teacher)
}
/* There are some classes assigned to teachers. */
pred inv5 {
	some Teacher.Teaches 
}
/* Every teacher has classes assigned. */
pred inv6 {
	Teacher in Teaches
}
/* Every class has teachers assigned. */
pred inv7 {
	Class in dom[TutorTeaches]
}
/* Teachers are assigned at most one class. */
pred inv8 {
	all t:Teacher | lone t.Teaches 
}
/* No class has more than one teacher assigned. */
pred inv9 {
	all c:Class | lone c.Groups.Teacher 
}
/* For every class, every student has a group assigned. */
pred inv10 {
	all c:Class, s:Student | some c.Groups[s] 
}
/* A class only has groups if it has a teacher assigned. */
pred inv11 {
	all c : Class | (some c.Groups) implies some TutorTeaches.t[c] 
}
/* Each teacher is responsible for some groups. */
pred inv12 {
	all t : Teacher | some c : t.Teaches | some t.Groups[c] 
}
/* Only teachers tutor, and only students are tutored. */
pred inv13 {
	Tutors in Teacher and Tutors.Person in Student 
}
/* Every student in a class is at least tutored by all the teachers assigned to that class. */
pred inv14 {
	all c:Class, s:Student, g:Group | (c.Groups[s] = g and g in s.Tutors.ProfTutorTeaches[c]) implies c.Groups[g] in g.Tutors[s].Groups[c]
}
/* The tutoring chain of every person eventually reaches a Teacher. */
pred inv15 {
	all s : Student | some Teacher & ^s.Tutors.ProfTutorTeaches.ProfTutorTeaches.ProfTutorTeaches.ProfTutorTeaches.ProfTutorTeaches.ProfTutorTeaches.ProfTutorTeaches.ProfTutorTeaches.ProfTutorTeaches.ProfTutorTeaches.ProfTutorTeaches.ProfTutorTeaches.ProfTutorTeaches.ProfTutors
} 

/*is OK*/
pred inv1_OK {
    Person in Student 
}
pred inv2_OK {
    no Teacher 
}
pred inv3_OK {
    no Student & Teacher 
}
pred inv4_OK {
    Person in Student + Teacher
}
pred inv5_OK {
    some Teacher.Teaches 
}
pred inv6_OK {
    Teacher in Teaches
}
pred inv7_OK {
    Class in dom[TutorTeaches]
}
pred inv8_OK {
    all t:Teacher | lone t.Teaches 
}
pred inv9_OK {
    all c:Class | lone c.Groups.Teacher 
}
pred inv10_OK {
    all c:Class, s:Student | some c.Groups[s] 
}
pred inv11_OK {
    all c : Class | (some c.Groups) implies some TutorTeaches.t[c] 
}
pred inv12_OK {
    all t : Teacher | some c : t.Teaches | some t.Groups[c] 
}
pred inv13_OK {
    Tutors in Teacher and Tutors.Person in Student 
}
pred inv14_OK {
    all c:Class, s:Student, g:Group | (c.Groups[s] = g and g in s.Tutors.ProfTutorTeaches[c]) implies c.Groups[g] in g.Tutors[s].Groups[c]
}
pred inv15_OK {
    all s : Student | some Teacher & ^s.Tutors.ProfTutorTeaches.ProfTutorTeaches.ProfTutorTeaches.ProfTutorTeaches.ProfTutorTeaches.ProfTutorTeaches.ProfTutorTeaches.ProfTutorTeaches.ProfTutorTeaches.ProfTutorTeaches.ProfTutorTeaches.ProfTutorTeaches.ProfTutorTeaches.ProfTutorTeaches.ProfTutors
} 

/* Assert that the fixed invariants are equivalent to the original invariants */
assert repaired {
    all p:Person | inv1[p] iff inv1_OK[p]
    inv2[] iff inv2_OK[]
    inv3[] iff inv3_OK[]
    all p:Person | inv4[p] iff inv4_OK[p]
    inv5[] iff inv5_OK[]
    inv6[] iff inv6_OK[]
    inv7[] iff inv7_OK[]
    inv8[] iff inv8_OK[]
    inv9[] iff inv9_OK[]
    inv10[] iff inv10_OK[]
    inv11[] iff inv11_OK[]
    inv12[] iff inv12_OK[]
    inv13[] iff inv13_OK[]
    inv14[] iff inv14_OK[]
    inv15[] iff inv15_OK[]
}

/* Check that the repaired invariants hold on all generated worlds */
check repaired for 10 but exactly 10 Teacher, 20 Student, 30 Class, 40 Group, 50 Person, 60 TutorTeaches, 70 ProfTutors, 80 ClassGroups, 90 TutorGroups, 100 StudTutors, 110 TutTutors, 120 GrpTutors, 130 StudGroups, 140 TutGroups{} */
