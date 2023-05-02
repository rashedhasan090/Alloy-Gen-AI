pred inv12_OK {
 all t : Teacher | some c : t.Teaches | some p : Person, g : Group | c->p->g in Groups 
}