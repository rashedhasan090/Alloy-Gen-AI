
pred inv14_OK {
    all s : Student, c : Class, g : Group | (c.Groups[s] = g) implies 
    all t : Teacher | t.Teaches = c implies s in t.Tutors
}

The corrected predicate uses the correct syntax for accessing the Groups relation and also fixes the implication that was originally incorrectly written.