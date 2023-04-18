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
    Groups : Person -> Group,
    /* Each class is assigned to a teacher. */
    Assigned: Teacher
}

/* Some persons are teachers. */
sig Teacher extends Person {}

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
    some Teacher.Teaches
}

/* Every teacher has classes assigned. */
pred inv6 {
    Teacher in Assigned.Teaches
}

/* Every class has a teacher assigned. */
pred inv7 {
    all c : Class | one c.Assigned
}

/* Teachers are assigned at most one class. */
pred inv8 {
    all t : Teacher | lone t.Teaches
}

/* No class has more than one teacher assigned. */
pred inv9 {
    all c : Class | lone t : Teacher | t -> c in Assigned.Teaches
}

/* For every class, every student has a group assigned. */
pred inv10 {
    all c : Class, s : Student | some c.Groups[s]
}

/* A class only has groups if it has a teacher assigned. */
pred inv11 {
    all c : Class | (some c.Groups) implies some t : Teacher | t -> c in Assigned.Teaches
}

/* Each teacher is responsible for some groups. */
pred inv12 {
    all t : Teacher | some (t.Teaches).Groups
}

/* Only teachers tutor, and only students are tutored. */
pred inv13 {
    Tutors.Person in Teacher and Person.Tutors in Student
}

/* Every student in a class is at least tutored by all the teachers assigned to that class. */
pred inv14 {
    all s : Student, c : Class | some t : Teacher | t -> s in Tutors and t -> c in Assigned.Teaches and c -> s in Groups
}

/* The tutoring chain of every person eventually reaches a teacher. */
pred inv15 {
    all s : Student | some t : Teacher | t -> s in ^Tutors
}

/* Perfect oracle commands */
check inv1 expect 0
check inv2 expect 0
check inv3 expect 0 
check inv4 expect 0
check inv5 expect 0
check inv6 expect 0
check inv7 expect 0
check inv8 expect 0
check inv9 expect 0
check inv10 expect 0
check inv11 expect 0
check inv12 expect 0
check inv13 expect 0
check inv14 expect 0
check inv15 expect 0