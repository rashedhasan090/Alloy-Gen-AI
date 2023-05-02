
pred inv14_OK {
  all s:Student, c:Class | some t:Teacher | t.Teaches = c and (some g:Group | g = c.Groups[s]) implies t in s.^Tutors
}