/* The registered persons. */
sig Person  {
    /* Each person tutors a set of persons. */
    Tutors : set Person,
    /* Each person teaches a set of classes. */
    Teaches : set Class,
    /* Each person is either a student or a teacher. */
    isStudent : one  Bool,
    isTeacher : one Bool
}{
    /* A person can only be a student or a teacher, not both */
    isStudent != isTeacher
}

/* The registered groups. */
sig Group {}

/* The registered classes. */
sig Class  {
    /* Each class has a set of persons assigned to a group. */
    Groups : Person -> Group
}

/* Some persons are teachers. */
sig Teacher extends Person  {
    isStudent = no,
    isTeacher = lone Bool
}

/* Some persons are students. */
sig Student extends Person  {
    isStudent = lone Bool,
    isTeacher = no
}

/* Every person is a student. */
pred inv1 {
    all p: Person | p.isStudent = true
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
    all p:Person | p.isStudent = true || p.isTeacher = true
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

/* No class has more than a teacher assigned. */
pred inv9 {
    all c:Class | lone Teaches.c & Teacher 
}

/* For every class, every student has a group assigned. */
pred inv10 {
    all c:Class, s:Student | some s.(c.Groups) 
}

/* A class only has groups if it has a teacher assigned. */
pred inv11 {
    all c : Class | (some c.Groups) implies some Teacher & Teaches.c 
}

/* Each teacher is responsible for some groups. */
pred inv12 {
    all t:Teacher | some g:Group | g in t.Teaches.Groups.Object
}

/* Only teachers tutor, and only students are tutored. */
pred inv13 {
    Tutors.Person in Teacher and Person.Tutors in Student 
}

/* Every student in a class is at least tutored by all the teachers
 * assigned to that class. */
pred inv14 {
    all s : Person, c : Class, t : Person, g : Group | (c -> s -> g in Groups) and t -> c in Teaches implies t -> s in Tutors
}

/* The tutoring chain of every person eventually reaches a Teacher. */
pred inv15 {
    all s : Person | some Teacher & ^Tutors.s
}

// Asserts the original invariants iff the repaired invariants
pred assert_invariants_repaired {
    inv1[] iff all p:Person | p.isStudent = true
    inv2[] iff no Teacher
    inv3[] iff no Student & Teacher
    inv4[] iff all p:Person | p.isStudent = true || p.isTeacher = true
    inv5[] iff some Teacher.Teaches
    inv6[] iff Teacher in Teaches.Class
    inv7[] iff Class in Teacher.Teaches
    inv8[] iff all t:Teacher | lone t.Teaches
    inv9[] iff all c:Class | lone t:Teacher | t in Teaches.c
    inv10[] iff all c:Class, s:Student | some s.(c.Groups)
    inv11[] iff all c:Class | (some c.Groups) implies some Teacher & Teaches.c
    inv12[] iff all t:Teacher | some g:Group | g in t.Teaches.Groups.Object
    inv13[] iff Tutors.Person in Teacher and Person.Tutors in Student
    inv14[] iff all s : Person, c : Class, t : Person, g : Group | (c -> s -> g in Groups) and t -> c in Teaches implies t -> s in Tutors
    inv15[] iff all s : Person | some Teacher & ^Tutors.s
}

// Checks if the repaired invariants hold
check assert_invariants_repaired for 10
