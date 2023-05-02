The fixed code for inv5 is:

pred inv5_OK {
    all s:State, e:Event | some s':State | s->e->s' in trans && s'.trans.Event = s.trans.Event 
}
assert inv5_Repaired {
    inv5[] iff inv5_OK[]
}