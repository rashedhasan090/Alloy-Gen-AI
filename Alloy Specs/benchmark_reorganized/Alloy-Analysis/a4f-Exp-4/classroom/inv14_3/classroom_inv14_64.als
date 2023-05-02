
/* Every student in a class is tutored by all the teachers assigned to that class. */
pred inv14 {
    all c:Class, s:Student | some t:Teacher | t.Teaches = c.Teaches & s in c.Groups[t]
}