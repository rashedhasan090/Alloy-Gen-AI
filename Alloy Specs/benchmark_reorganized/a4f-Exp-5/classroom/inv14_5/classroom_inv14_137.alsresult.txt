/* Fixed Predicate: Every student in a class has a group assigned to a teacher */
pred inv14_OK {
  all s:Student,c:Class |
    (some g:Group | g = c.Groups[s]) implies
    (some t:Teacher | t.Teaches = c and s in t.Tutors)
}