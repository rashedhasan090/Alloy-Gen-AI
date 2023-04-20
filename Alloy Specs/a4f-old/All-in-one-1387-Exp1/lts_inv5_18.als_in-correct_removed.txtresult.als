The bug in this specification is in the commented out code for inv5. The correct code to fix this bug is:

/* 
All the states have the same events available. 
*/ 
pred inv5 { 
    all s1, s2 : State | s1.trans.Event = s2.trans.Event --fixed 
}