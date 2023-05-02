/* Fixed Code */
sig Person {
    Tutors: set Person,
    Teaches: set Class
}
sig Group {}
sig Class {
    Groups: set Person -> Group
}
sig Teacher extends Person {}
sig Student extends Person {}
pred inv1 {
    Person in Student
}
pred inv2 {
    no Teacher
}
pred inv3 {
    no Student & Teacher
}
pred inv4 {
    Person in Teacher + Student
}
pred inv5 {
    some Teacher.Teaches
}
pred inv6 {
    Teacher.Teaches in Class
}
pred inv7 {
    Class in Teacher.Teaches
}
pred inv8 {
    all t: Teacher | lone t.Teaches
}
pred inv9 {
    all c: Class | lone Function[c.Groups, Teacher]
}
pred inv10 {
    all c: Class, s: Student | some p: Person | p.(c.Groups) = s
}
pred inv11 {
    all c: Class | (some c.Groups) implies some t: Teacher | t.Teaches = c
}
pred inv12 {
    all t: Teacher | some g: Group | t.Teaches.Groups = g
}
pred inv13 {
    Teacher.Tutors = Teacher and Student.Tutors = Student
}
pred inv14 {
    all c: Class, s: Student | some t: Teacher, g: Group | (c.Groups[t] = g) and (s.Tutors in t.Tutors) implies (s.Tutors = t)
}
pred inv15 {
    all s: Person | some t: Teacher | ^s.Tutors = t
}