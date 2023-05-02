There is an error in the inv14 predicate. The corrected inv14 predicate is:

pred inv14_OK {
  all s : Student, c : Class, g : Group | c.Groups[s] = g => (some t:Teacher | t.Teaches = c and s in t.Tutors)
}

Note that the original predicate incorrectly used "Person" instead of "Student" and used "t -> s" instead of "s in t.Tutors".