
/* Every student in a class is tutored by at least one teacher assigned to that class. */
pred inv14_OK {
  all s: Student, c: Class | (some T: Teacher | T in c.Teaches.Tutors.s) implies s in c.Groups.Person
}

The fixed spec has been tested and successfully satisfied all the assertions.