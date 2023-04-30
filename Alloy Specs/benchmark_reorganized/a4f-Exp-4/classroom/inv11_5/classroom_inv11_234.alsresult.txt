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
    some Teacher.Teaches
}
/* Every teacher has classes assigned. */
pred inv6 {
    Teacher.Teaches = Class
}
/* Every class has teachers assigned. */
pred inv7 {
    Class in Teacher.Teaches
}
/* Teachers are assigned at most one class. */
pred inv8 {
    all t : Teacher | lone(t.Teaches)
}
/* No class has more than one teacher assigned. */
pred inv9 {
    all c : Class | lone(Teaches.c & Teacher)
}
/* For every class, every student has a group assigned. */
pred inv10 {
    all c : Class, s : Student | some(s.(c.Groups))
}
/* A class only has groups if it has a teacher assigned. */
pred inv11 {
    all x : Class | (some y : Person, g : Group | x -> y -> g in Groups implies y in Teacher)
}
/* Each teacher is responsible for some groups. */
pred inv12 {
    all t : Teacher | some(t.Teaches.Groups)
}
/* Only teachers tutor, and only students are tutored. */
pred inv13 {
    Tutors.Person in Teacher and Person.Tutors in Student
}
/* Every student in a class is tutored by all the teachers assigned to that class. */
pred inv14 {
    all s : Student, c : Class | some t : Teacher | (c -> s -> _ in Groups) implies t -> s in Tutors
}
/* The tutoring chain of every person eventually reaches a Teacher. */
pred inv15 {
    all s : Person | some Teacher & ^Tutors.s
}

/* IFF PERFECT ORACLE */
assert invs_Repaired {
    all i : int | let name = "inv" + i.toString() + "_OK" | eval(name++"[] iff "+"inv"+i.toString()+"[]")
}
check invs_Repaired for 1..15

/* The repaired predicate inv11_OK */
pred inv11_OK {
    all x : Class | (some y : Person | x.Teaches[y] implies y in Teacher)
}
check inv11_OK
assert inv11_Repaired {
    inv11[] iff inv11_OK[]
}
check inv11_Repaired