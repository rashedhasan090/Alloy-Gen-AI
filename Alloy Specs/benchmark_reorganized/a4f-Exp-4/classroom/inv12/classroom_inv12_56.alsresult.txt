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
sig Teacher extends Person  {}

/* Some persons are students. */
sig Student extends Person  {}

/* Every person is a student, but not all are teachers. */
pred inv1 {
    Person in Student + Teacher
}

/* There are no students who are also teachers. */
pred inv2 {
    no Student & Teacher
}

/* There are no persons who are neither students nor teachers. */
pred inv3 {
    Person in Student + Teacher
}

/* At least one teacher has at least one class assigned. */
pred inv4 {
    some t : Teacher | some c : Class | t.Teaches = c
}

/* Every teacher has at least one class assigned. */
pred inv5 {
    all t : Teacher | some c : Class | t.Teaches = c
}

/* Teachers are assigned at most one class each. */
pred inv6 {
    all t : Teacher | lone t.Teaches
}

/* No class has more than one teacher assigned. */
pred inv7 {
    all c : Class | lone t : Teacher | t.Teaches = c
}

/* Every student in a class is assigned to at least one group. */
pred inv8 {
    all c : Class, s : Student | some g : Group | c.Groups.s = g
}

/* Classes that have groups assigned also have teachers assigned. */
pred inv9 {
    all c : Class | some t : Teacher | c.Teaches = t => some g : Group | c.Groups.t = g
}

/* Every teacher is responsible for at least one group. */
pred inv10 {
    all t : Teacher | some c : Class, g : Group | t.Teaches = c and c.Groups.t = g
}

/* Only teachers tutor, and only students are tutored. */
pred inv11 {
    Tutors.Person in Teacher and Person.Tutors in Student 
}

/* Every student taking a class is tutored by at least one of the teachers assigned to the class. */
pred inv12 {
    all c : Class, s : Student | some t : Teacher | t.Teaches = c and s in t.Tutors
}

/* For every person, there exists a chain of tutors that ends with a teacher. */
pred inv13 {
    all p : Person | some t : Teacher | p in t.^Tutors
}

/* Assert all invariants are satisfied. */
assert Valid {
    all inv : (Person + Teacher + Student + Group + Class) -> lone bool | inv.(inv) 
}

/* Check for some error counterexamples. */
run Valid for 3 but 2 int, exactly 3 Teacher, exactly 6 Student, exactly 7 Group, exactly 10 Class, exactly 20 OrderedPair, exactly 30 Person, exactly 60 int, exactly 100 Group -> Person, exactly 150 Group -> Class, exactly 200 Class -> Person */