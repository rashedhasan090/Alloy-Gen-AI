Fixed code:

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
sig Teacher extends Person {
    teaches: set Class
} 
/* Some persons are students. */
sig Student extends Person {}
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
	some Teacher.teaches 
}
/* Every teacher has classes assigned. */
pred inv6 {
	Teacher.teaches = Teaches & Teacher 
}
/* Every class has teachers assigned. */
pred inv7 {
	all c:Class | some t:Teacher | t.teaches = c  
}
/* Teachers are assigned at most one class. */
pred inv8 {
	all t:Teacher | lone teaches.t 
}
/* No class has more than a teacher assigned. */
pred inv9 {
	all c:Class | lone t:Teacher | t.teaches = c 
}
/* For every class, every student has a group assigned. */
pred inv10 {
	all c:Class, s:Student | some g:Group | (s->g) in c.Groups 
}
/* A class only has groups if it has a teacher assigned. */
pred inv11 {
	all c : Class | (some c.Groups) implies some t:Teacher | t.teaches = c 
}
/* Each teacher is responsible for some groups. */
pred inv12 {
	all t : Teacher | some c:Class, g:Group | (t.teaches = c) and ((t->g) in c.Groups)   
}
/* Only teachers tutor, and only students are tutored. */
pred inv13 {
	all t:Teacher,s:Student | s->t not in Tutors 
}
/* Every student in a class is at least tutored by all the teachers
 * assigned to that class. */
pred inv14 {
	all s : Student, c : Class, t : Teacher, g : Group | (c -> s -> g in Groups) and (t in c.teaches) implies (t -> s in Tutors)
}
/* The tutoring chain of every person eventually reaches a Teacher. */
pred inv15 {
	all s : Student | some t:Teacher | t in ^Tutors.s
}

/* Repairing the invariant inv13 */
pred repair_inv13 {
    all p:Person | ((Teacher in p.Tutors) and ((Student in p.Tutors) implies no Teacher in p.Tutors))
}

run repair_inv13 for 5 but 1 Teacher, 1 Student, 2 Class, 2 Group, exactly 2 Student.Tutors, exactly 1 Teacher.Teaches