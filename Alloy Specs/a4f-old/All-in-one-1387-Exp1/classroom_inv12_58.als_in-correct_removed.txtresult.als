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
    /* Each class has a set of teachers assigned to it. */
    Teachers : set Teacher
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
    Teacher in Teaches.Teacher
}

/* Every class has teachers assigned. */
pred inv7 {
    Class in Teachers.Teaches
}

/* Teachers are assigned at most one class. */
pred inv8 {
    all t:Teacher | lone t.Teaches
}

/* No class has more than one teacher assigned. */
pred inv9 {
    all c:Class | lone c.Teachers
}

/* For every class, every student has a group assigned. */
pred inv10 {
    all c:Class, s:Student | some c.Groups[s]
}

/* A class only has groups if it has a teacher assigned. */
pred inv11 {
    all c : Class | (some c.Groups) implies some c.Teachers
}

/* Each teacher is responsible for some groups. */
pred inv12 {
    all t : Teacher | some t.Teaches.Groups
}

/* Only teachers tutor, and only students are tutored. */
pred inv13 {
    Tutors.Person in Teacher and Person.Tutors in Student
}

/* Every student in a class is at least tutored by all the teachers
   assigned to that class. */
pred inv14 {
    all s : Student, c : Class | (s -> c) in Groups implies all t : c.Teachers | (t -> s) in Tutors
}

/* The tutoring chain of every person eventually reaches a Teacher. */
pred inv15 {
    all s : Person | some Teacher & ^s.Tutors
}

/* IFF PERFECT ORACLE */
assert PerfectOracle {
    all i: int | check inv1 expect i
    all i: int | check inv2 expect i
    all i: int | check inv3 expect i
    all i: int | check inv4 expect i
    all i: int | check inv5 expect i
    all i: int | check inv6 expect i
    all i: int | check inv7 expect i
    all i: int | check inv8 expect i
    all i: int | check inv9 expect i
    all i: int | check inv10 expect i
    all i: int | check inv11 expect i
    all i: int | check inv12 expect i
    all i: int | check inv13 expect i
    all i: int | check inv14 expect i
    all i: int | check inv15 expect i
}