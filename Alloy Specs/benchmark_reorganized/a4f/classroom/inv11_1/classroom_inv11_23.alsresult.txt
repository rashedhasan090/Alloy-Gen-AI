/*
The registered persons.
*/          
sig Person {
   /* Each person tutors a set of persons. */
   Tutors : set Person,
   /* Each person teaches a set of classes. */
   Teaches : set Class
}           
/*
The registered groups.
*/
sig Group {}        
/*
The registered classes.
*/  
sig Class {
   /* Each class has a set of persons assigned to a group. */
   Groups : Person -> lone Group
}         
/*
Some persons are teachers.
*/  
sig Teacher extends Person {}
/*
Some persons are students.
*/  
sig Student extends Person {}
/*
Every person is a student.
*/
pred inv1 {
   Person in Student
}
/*
There are no teachers.
*/  
pred inv2 {
   no Teacher
}
/*
No person is both a student and a teacher.
*/  
pred inv3 {
   no Student & Teacher
}
/*
No person is neither a student nor a teacher.
*/
pred inv4 {
   Person in (Student + Teacher)
}
/*
There are some classes assigned to teachers.
*/  
pred inv5 {
   some t: Teacher | t.Teaches != none
}   
/*
Every teacher has classes assigned.
*/  
pred inv6 {
   Teacher.Teaches != none
}
/*
Every class has teachers assigned.
*/  
pred inv7 {
   Class.Teaches != none
}
/*
Teachers are assigned at most one class.
*/  
pred inv8 {
   all t:Teacher | lone t.Teaches
}
/*
No class has more than one teacher assigned.
*/
pred inv9 {
   all c:Class | lone gt:Person | gt -> c in Teacher & c.Groups[gt] != none
}
/*
For every class, every student has a group assigned.
*/
pred inv10 {
   all c:Class, s:Student | some g:Group | c.Groups[s] = g
}
/*
A class only has groups if it has a teacher assigned.
*/
pred inv11 {
   all c:Class | c.Groups != none => c.Teacher != none
}
/*
Each teacher is responsible for some groups.
*/
pred inv12 {
   all t:Teacher | some c:Class | t -> c in Teaches && some g:Group | c -> t -> g in Groups
}
/*
Only teachers tutor, and only students are tutored.
*/
pred inv13 {
   all t:Teacher, s:Student | s not in t.Tutors
}
/*
Every student in a class is at least tutored by all the teachers assigned to that class.
*/
pred inv14 {
   all c:Class, s:Student | c.Groups[s] != none => s in c.Teacher.Tutors
}
/*
The tutoring chain of every person eventually reaches a Teacher.
*/
pred inv15 {
   all s:Person | some t:Teacher | s in t.^Tutors
}

run inv1
run inv2
run inv3
run inv4
run inv5
run inv6
run inv7
run inv8
run inv9
run inv10
run inv11
run inv12
run inv13
run inv14
run inv15
/*
Note: Since some variable and signature names are not defined or utilized, they have been removed from the fixed code to simplify it.
*/