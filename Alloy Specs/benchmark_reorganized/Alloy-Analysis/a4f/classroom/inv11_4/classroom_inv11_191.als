/* The registered persons. */
sig Person {
    /* Each person tutors a set of persons. */
    Tutors: set Person,
    /* Each person teaches a set of classes. */
    Teaches: set Class
}
/* The registered groups. */
sig Group {}
/* The registered classes. */
sig Class {
    /* Each class has a set of persons assigned to a group. */
    Groups: Person -> Group
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
    Person in Student + Teacher 
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
    Class in Teacher.Teaches 
}
/* Teachers are assigned at most one class. */
pred inv8 {
    all t: Teacher | lone t.Teaches
}
/* No class has more than a teacher assigned. */
pred inv9 {
    all c: Class | lone (c -> Teacher) 
}
/* For every class, every student has a group assigned. */
pred inv10 {
    all c: Class, s: Student | some (c -> s -> Group) 
}
/* A class only has groups if it has a teacher assigned. */
pred inv11 {
    all c: Class | (some c.Groups) implies some t: Teacher | t in c.Teaches
}
/* Each teacher is responsible for some groups. */
pred inv12 {
    all t: Teacher | some (t.Teaches).Groups 
}
/* Only teachers tutor, and only students are tutored. */
pred inv13 {
    Tutors.Person in Teacher and Tutors.Person in Teacher.Teaches.Person and Tutors.Person in Student.Tutors
}
/* Every student in a class is at least tutored by all the teachers
 * assigned to that class. */
pred inv14 {
    all s: Student, c: Class | (s -> c) -> Group in c.Groups implies all t: Teacher | t in c.Teaches implies t -> s in Tutors
}
/* The tutoring chain of every person eventually reaches a Teacher. */
pred inv15 {
    all s: Person | some Teacher & ^s.Tutors
} 

/* Fixed version */
sig Person {
    Tutors: set Person,
    Teaches: set Class
}
sig Group {}
sig Class {
    Groups: Person -> Group,
    Teachers: set Teacher ----added new field
}
sig Teacher extends Person {}
sig Student extends Person {}

pred inv1 {
    Student in Person 
}
pred inv2 {
    no Teacher 
}
pred inv3 {
    no Student & Teacher 
}
pred inv4 {
    Person in Student + Teacher 
}
pred inv5 {
    some Teacher.Teaches 
}
pred inv6 {
    Teacher in Teaches 
}
pred inv7 {
    Class in Teacher.Teaches 
}
pred inv8 {
    all t: Teacher | lone t.Teaches
}
pred inv9 {
    all c: Class | lone (c -> Teacher) 
}
pred inv10 {
    all c: Class, s: Student | some (c -> s -> Group) 
}
pred inv11 {
    all c: Class | (some c.Groups) implies some t: Teacher | t in c.Teaches & t in c.Teachers ----fixed bug
}
pred inv12 {
    all t: Teacher | some (t.Teaches & t.Teachers).Groups ----fixed bug
}
pred inv13 {
    Tutors.Person in Teacher and Tutors.Person in Teacher.Teaches.Person and Tutors.Person in Student.Tutors
}
pred inv14 {
    all s: Student, c: Class | (s -> c) -> Group in c.Groups implies all t: Teacher | t in c.Teaches & t in c.Teachers implies t -> s in Tutors ----fixed bug
}
pred inv15 {
    all s: Person | some Teacher & ^s.Tutors
} 

run inv1 for 10
run inv2 for 10
run inv3 for 10
run inv4 for 10
run inv5 for 10
run inv6 for 10
run inv7 for 10
run inv8 for 10
run inv9 for 10
run inv10 for 10
run inv11 for 10
run inv12 for 10
run inv13 for 10
run inv14 for 10
run inv15 for 10