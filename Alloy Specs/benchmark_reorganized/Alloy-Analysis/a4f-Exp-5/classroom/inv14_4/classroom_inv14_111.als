pred inv14_OK {
  all s : Student, c : Class | some c.Groups and (c.Groups.s).Teacher in c.Teaches implies (s.Tutors & (c.Groups.s).Tutors) in (c.Teaches.Tutors)
}