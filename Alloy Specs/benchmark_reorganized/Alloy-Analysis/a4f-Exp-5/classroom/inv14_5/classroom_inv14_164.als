pred inv14_OK {
    all c : Class, s : Student, g : Group | (c->s->g in Groups) implies all t : Teacher |
    t in c.Teaches and s in t.Tutors
}

assert inv14_Repaired {
    inv14[] iff inv14_OK[]
}

check inv14_Repaired expect 0