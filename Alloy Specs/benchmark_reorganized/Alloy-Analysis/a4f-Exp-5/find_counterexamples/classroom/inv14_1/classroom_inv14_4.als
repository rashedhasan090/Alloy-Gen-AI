The fixed code for inv14 is:

pred inv14_ok {
    all c:Class, s:Student, t:Teacher, g:Group| c.Groups[s]=g and t.Teaches=c implies s in t.Tutors
}

and the corresponding repaired assertion is:

assert inv14_Repaired {
    inv14[] iff inv14_ok[]
}