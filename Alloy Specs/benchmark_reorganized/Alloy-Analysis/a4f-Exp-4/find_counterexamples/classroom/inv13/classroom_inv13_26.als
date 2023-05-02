
/* Only teachers tutor, and only students are tutored. */
pred inv13 {
    all t : Teacher | t in Tutors
    all s : Student | s in Tutors
    no s : Teacher | s in Tutors
    no t : Student | t in Tutors
}