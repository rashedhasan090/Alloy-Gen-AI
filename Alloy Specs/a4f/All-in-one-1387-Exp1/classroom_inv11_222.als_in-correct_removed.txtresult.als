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
    /* Each class has a set of teachers assigned. */
    AssignedTeachers : set Teacher,
    /* Each class has a set of students. */
    Students : set Student
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

/* Some persons are assigned to a class as teachers. */
pred inv5 {
    some c:Class | c.AssignedTeachers in Teacher
}

/* For every assigned teacher, they teach the assigned classes */
pred inv6 {
    all c:Class | c.AssignedTeachers.Teaches in c
}

/* For every student in a class, all assigned teachers to that class teach the student */ 
pred inv7 {
    all c:Class, s:Student | c.Students = s.Tutors and s.Tutors.Teaches in c.AssignedTeachers
}

/* There is at most one assigned teacher per class */
pred inv8 {
    all c:Class | lone c.AssignedTeachers
}

/* No class has a teacher assigned more than once */
pred inv9 {
    no c1,c2:Class, t:Teacher | (t in c1.AssignedTeachers and t in c2.AssignedTeachers) and (c1 != c2)
}

/* A class only has groups if it has a teacher assigned */
pred inv10 {
    all c : Class | (some c.Groups) implies some c.AssignedTeachers
}

/* Each teacher is responsible for some groups */
pred inv11 {
    all t : Teacher | some c : t.Teaches, g : Group | g = c.Groups[t]
}

/* Only teachers tutor, and only students are tutored */
pred inv12 {
    all t:Teacher | t.Tutors = t.Teaches.Students and all s:Student | s.Tutors = Tutors.s 
}

/* Every student in a class is at least tutored by all the teachers
 * assigned to that class. */
pred inv13 {
    all c:Class, s:Student | s.Tutors in c.AssignedTeachers.Tutors
}

/* The tutoring chain of every person eventually reaches a Teacher. */
pred inv14 {
    all s:Person | some t:Teacher | s in ^t.Tutors
}

/* IFF PERFECT ORACLE */
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
run {} for 5 */
```