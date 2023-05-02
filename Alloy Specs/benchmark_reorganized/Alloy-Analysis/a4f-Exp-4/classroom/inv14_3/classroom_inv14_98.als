
pred inv14_OK{
    all s: Student, c: Class | some t: Teacher, g: Group | c->s->g in Groups[t] implies s in g.Persons
}

The fixed inv14 checks that for every student in a class, there is at least one teacher assigned to that class such that the student is in one of the groups that the teacher is responsible for.