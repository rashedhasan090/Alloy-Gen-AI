
/* Every student in a class is at least tutored by all the teachers
 * assigned to that class. */
pred inv14_OK {
  all c : Class, s : Student | s in c.groups.persons implies s in c.tutors and all t : Teacher | t.teaches = c.teaches implies (t,s) in c.groups
}