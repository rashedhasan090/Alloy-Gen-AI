Fixed code:

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
    Person = Student + Teacher
}
/* There are some classes assigned to teachers. */
pred inv5 {
    some c: Class | some t: c.Teaches | t in Teacher
}
/* Every teacher has classes assigned. */
pred inv6 {
    Teacher.Teaches = Class
}
/* Every class has teachers assigned. */
pred inv7 {
    Class.Teaches = Teacher
}
/* Teachers are assigned at most one class. */
pred inv8 {
    all t: Teacher | lone t.Teaches
}
/* No class has more than one teacher assigned. */
pred inv9 {
    all c: Class | lone c.Teaches
}
/* For every class, every student has a group assigned. */
pred inv10 {
    all c: Class, s: Student | some c.Groups.s
}
/* A class only has groups if it has a teacher assigned. */
pred inv11 {
    all c: Class, g: Group | (some c.Groups.g) implies (some t: Teacher | (t in c.Teaches) and (c->t->g in Groups))
}
/* Each teacher is responsible for some groups. */
pred inv12 {
    all t: Teacher | some c: t.Teaches | some g: Group | c->t->g in Groups
}
/* Only teachers tutor, and only students are tutored. */
pred inv13 {
    Teacher.Tutors = Teacher
    Student.Tutors = Student
}
/* Every student in a class is tutored by at least one teacher assigned to that class. */
pred inv14 {
    all c: Class, s: Student | some t: c.Teaches | t in s.Tutors
}
/* The tutoring chain of every person eventually reaches a Teacher. */
pred inv15 {
    all s: Person | some t: Teacher | s in t.^Tutors
} 
/* Perfect Oracle repairs */
pred inv11_OK {
    all c: Class, g: Group | (some c.Groups.g) implies (some t: Teacher | (t in c.Teaches) and (c->t->g in Groups) and (t->c in Teaches))
}
assert inv11_Repaired {
    inv11[] iff inv11_OK[]
}
check inv11_Repaired expect 0