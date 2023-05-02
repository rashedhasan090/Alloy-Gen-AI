fixed code:
pred inv7_OK {
    all x : State | some Init.(*(~(x.trans)).*Init) 
}