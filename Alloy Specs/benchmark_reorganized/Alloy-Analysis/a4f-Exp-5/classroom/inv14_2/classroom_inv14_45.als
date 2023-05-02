Fixed code for pred inv14:

pred inv14_OK {
  all c:Class,s:Student | some t:Teacher | s in c.Groups[group] implies t in s.Tutors & t in c.Teaches
}