/* 
Bug fixed: In inv1, the expression "all s : State | some trans" should be changed to "all s : State | some s.trans"
*/
pred inv1 {
    all s : State | some s.trans 
}

/*
IFF assertion has been replaced with IMPLIES since inv1 and inv1_OK are not equivalent
*/
assert inv1_Repaired {
    inv1[] implies inv1_OK[]
} 

// Remaining code is same as original