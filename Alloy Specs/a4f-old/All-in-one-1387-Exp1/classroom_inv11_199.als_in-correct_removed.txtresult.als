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
    Groups : Person -> set Group,
    /* Each class has a set of teachers. */
    Teachers : set Teacher
}

/* Some persons are teachers. */
sig Teacher extends Person {}

/* Some persons are students. */
sig Student extends Person {}

/* Every person is a student. */
fact inv1 {
    Person in Student
}

/* There are no teachers. */
fact inv2 {
    no Teacher
}

/* No person is both a student and a teacher. */
fact inv3 {
    no Student & Teacher
}

/* No person is neither a student nor a teacher. */
fact inv4 {
    Person in Student + Teacher
}

/* Some classes are assigned to teachers. */
fact inv5 {
    some Teacher.Teaches
}

/* Every teacher has classes assigned. */
fact inv6 {
    Teacher in Teach.Class
}

/* Every class has teachers assigned. */
fact inv7 {
    Class in Teacher.Teaches
}

/* Teachers are assigned at most one class. */
fact inv8 {
    all t : Teacher | lone t.Teaches
}

/* No class has more than one teacher assigned. */
fact inv9 {
    all c : Class | lone c.Teachers
}

/* For every class, every student has a group assigned. */
fact inv10 {
    all c : Class, s : Student | some s.(c.Groups)
}

/* A class only has groups if it has a teacher assigned. */
fact inv11 {
    all c : Class | (some c.Groups) implies some c.Teachers
}

/* Each teacher is responsible for some groups. */
fact inv12 {
    all t : Teacher | some (t.Teaches & c.Teachers).Groups
}

/* Only teachers tutor, and only students are tutored. */
fact inv13 {
    Tutors.Person in Teacher
    Person.Tutors in Student
}

/* Every student in a class is at least tutored by all the teachers
   assigned to that class. */
fact inv14 {
    all s : Student, c : Class, g : Group |
        (c -> s -> g in Groups) implies
            all t : c.Teachers | t -> s in t.Tutors
}

/* The tutoring chain of every person eventually reaches a Teacher. */
fact inv15 {
    all s : Student | some Teacher & ^s.Tutors
}