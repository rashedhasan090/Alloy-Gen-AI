The fixed code for inv11 pred is:
/* A class only has groups if it has a teacher assigned. */
pred inv11 {
 all c:Class|some t:Teacher | t in c.Groups
}