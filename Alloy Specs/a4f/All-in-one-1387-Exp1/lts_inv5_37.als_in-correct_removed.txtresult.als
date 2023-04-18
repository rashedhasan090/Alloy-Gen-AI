There is a commented out line in the pred inv5. The correct code is:

pred inv5 {
    all s,s1:State | s.trans.Event = s1.trans.Event --fixed
}