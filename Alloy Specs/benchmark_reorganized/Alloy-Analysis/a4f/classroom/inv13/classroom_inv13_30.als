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
    Teacher in Teaches 
}
/* Every class has teachers assigned. */
pred inv7 {
    all c: Class | some t: Teacher | t.Teaches = c
}
/* Teachers are assigned at most one class. */
pred inv8 {
    all t: Teacher | lone t.Teaches
}
/* No class has more than a teacher assigned. */
pred inv9 {
    all c: Class | lone c.Teaches
}
/* For every class, every student has a group assigned. */
pred inv10 {
    all c: Class, s: Student | some g: Group | (s->g) in c.Groups
}
/* A class only has groups if it has a teacher assigned. */
pred inv11 {
    all c: Class | (some c.Groups) implies some t: Teacher | t.Teaches = c
}
/* Each teacher is responsible for some groups. */
pred inv12 {
    all t: Teacher | some c: Class | t.Teaches = c and some g: Group | (t->g) in c.Groups
}
/* Only teachers tutor, and only students are tutored. */
pred inv13 {
    all p: Person | (p in Teacher) xor (all t: p.Tutors | t in Teacher) 
}
/* Every student in a class is at least tutored by all the teachers assigned to that class. */
pred inv14 {
    all c: Class, s: Student | some t: Teacher | t in c.Teaches and (s -> some g: Group | g in c.Groups and (t->g) in c.Groups) implies (t -> s) in Tutors
}
/* The tutoring chain of every person eventually reaches a Teacher. */
pred inv15 {
    all p: Person | some t: Teacher | t in ^p.Tutors
}
/* === Repairing the Alloy Model === */

/* inv1 is correct. */

/* inv2 is correct. */

/* inv3 is correct. */

/* inv4 is correct. */

/* inv5 is correct. */

/* inv6 is correct. */

/* Fixing inv7 -- Every class has teachers assigned. */
pred inv7_OK {
    all c: Class | c.Teaches != none
}
assert inv7_Repaired {
    inv7[] iff inv7_OK[]
}

/* Fixing inv8 -- Teachers are assigned at most one class. */
pred inv8_OK {
    all t: Teacher | lone t.Teaches
}
assert inv8_Repaired {
    inv8[] iff inv8_OK[]
}

/* Fixing inv9 -- No class has more than a teacher assigned. */
pred inv9_OK {
    all c: Class | lone c.Teaches
}
assert inv9_Repaired {
    inv9[] iff inv9_OK[]
}

/* Fixing inv10 -- For every class, every student has a group assigned. */
pred inv10_OK {
    all c: Class, s: Student | (c.Teaches != none) and (s -> some g: Group | g in c.Groups)
}
assert inv10_Repaired {
    inv10[] iff inv10_OK[]
}

/* Fixing inv11 -- A class only has groups if it has a teacher assigned. */
pred inv11_OK {
    all c: Class | (c.Groups != none) implies (c.Teaches != none)
}
assert inv11_Repaired {
    inv11[] iff inv11_OK[]
}

/* Fixing inv12 -- Each teacher is responsible for some groups. */
pred inv12_OK {
    all t: Teacher | some c: Class, g: Group | t.Teaches = c and (t->g) in c.Groups
}
assert inv12_Repaired {
    inv12[] iff inv12_OK[]
}

/* Fixing inv13 -- Only teachers tutor, and only students are tutored. */
pred inv13_OK {
    all p: Person | (p in Teacher) implies no (p.Tutors & Student) and (no (p.Tutors & Teacher) implies no (p in Student))
}
assert inv13_Repaired {
    inv13[] iff inv13_OK[]
}

/* Fixing inv14 -- Every student in a class is at least tutored by all the teachers assigned to that class. */
pred inv14_OK {
    all c: Class, s: Student | (s in c.Groups.Person) implies all t: (c.Teaches.Person & Teacher) | (t->s) in Tutors
}
assert inv14_Repaired {
    inv14[] iff inv14_OK[]
}

/* Fixing inv15 -- The tutoring chain of every person eventually reaches a Teacher. */
pred inv15_OK {
    all p: Person | (p in Teacher) or (some t: p.Tutors | t in Teacher)
}
assert inv15_Repaired {
    inv15[] iff inv15_OK[]
}

/* Checking that all invariants hold again. */
check inv1, inv2, inv3, inv4, inv5, inv6, inv7_Repaired, inv8_Repaired, inv9_Repaired, inv10_Repaired, inv11_Repaired, inv12_Repaired, inv13_Repaired, inv14_Repaired, inv15_Repaired

/* =========== End of Alloy Model =========== */