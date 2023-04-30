The bug was in the inv13 predicate which didn't include the Teacher and Student sigs in the expression. The fixed code is:

/* Only teachers tutor, and only students are tutored. */
pred inv13 {
    Teacher in Person.^~Tutors and Student in Person.^Tutors 
}
to:
/* Only teachers tutor, and only students are tutored. */
pred inv13 {
    Teacher in Person and Student in Person and Teacher.Tutors in Teacher and Student.Tutors in Teacher.Tutors and Student.Tutors in Student 
}