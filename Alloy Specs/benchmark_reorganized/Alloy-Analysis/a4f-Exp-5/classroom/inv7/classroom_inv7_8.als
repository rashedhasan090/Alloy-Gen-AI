sig Person  {
	Tutors : set Person, // Each person tutors a set of persons.
	Teaches : set Class  // Each person teaches a set of classes.
}
sig Group {}
/* The registered classes. */
sig Class  {
	Groups : Person -> Group // Each class has a set of persons assigned to a group.
}
sig Teacher extends Person  {}
sig Student extends Person  {}
pred inv1 {
	Person in Student 
}
pred inv2 {
	no Teacher 
}
pred inv3 {
	no Student & Teacher 
}
pred inv4 {
	Person in (Student + Teacher) 
}
pred inv5 {
	some Teacher.Teaches 
}
pred inv6 {
	Teacher in Teaches.Class
}
pred inv7 {
	all c:Class | some c.Teaches 
}
pred inv8 {
	all t:Teacher | lone t.Teaches 
}
pred inv9 {
	all c:Class | lone { p:Person | p in c.Teaches } = 1 
}
pred inv10 {
	all c:Class, s:Student | some s.(c.Groups)
}
pred inv11 {
	all c:Class | (some c.Groups) implies some Teacher & Teaches.c 
}
pred inv12 {
	all t : Teacher | some (t.Teaches).Groups 
}
pred inv13 {
	Tutors.Person in Teacher and Person.Tutors in Student  
}
pred inv14 {
	all s : Person, c : Class, t : Person, g : Group | (c -> s -> g in Groups) and t -> c in Teaches implies t -> s in Tutors 
}
pred inv15 {
	all s : Person | some Teacher & ^Tutors.s
}

pred inv7_OK {
	all c:Class | some (Teacher & c.Teaches)
}

assert inv7_Repaired {
	inv7[] iff inv7_OK[]
}

run inv7_Repaired for 5

check {
	inv1[] and
	inv2[] and
	inv3[] and
	inv4[] and
	inv5[] and
	inv6[] and
	inv7_Repaired[] and
	inv8[] and
	inv9[] and
	inv10[] and
	inv11[] and
	inv12[] and
	inv13[] and
	inv14[] and
	inv15[]
} for 5  but 4 Class, 4 Group, 4 Person, 4 Teacher, 8 Student, 8 Person->Group, 8 Person->Person, 8 Class->Person, 8 Teacher->Class, 2 Teacher->Person, 2 Class->Group, 2 Person->Bool, 2 Person->Class, 3 Class->Bool, 3 Person->Person, 3 Teacher->Bool, 5 Person->Person->Bool, 5 Person->Person->Person, 5 Class->Person->Bool, 5 Class->Person->Person, 5 Teacher->Class->Bool, 5 Teacher->Class->Person, 5 Class->Group->Person->Bool, 5 Class->Group->Person->Person, 5 Class->Group->Bool.