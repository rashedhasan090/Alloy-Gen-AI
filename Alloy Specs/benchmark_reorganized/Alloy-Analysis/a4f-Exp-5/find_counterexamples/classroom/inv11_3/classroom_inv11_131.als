Fixed code:

pred inv11_OK {
  all c : Class | (some c.Groups) implies some t:Teacher | t.Teaches = c
}

The bug was that the quantified expression was incomplete and did not check for a teacher assigned to the class. The fixed code checks that there exists some teacher that teaches the class and thus has groups assigned to it.