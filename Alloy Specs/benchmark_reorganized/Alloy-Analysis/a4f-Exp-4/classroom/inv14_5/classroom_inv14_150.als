
pred inv14_OK {
    all s:Student, c:Class | c.Groups.s != none implies 
    (c.Teaches & Teacher) in s.Tutors
}