There was a bug in inv6. The fixing code is as follows: 

/* Every teacher has classes assigned. */
pred inv6_OK {
 Teacher in Teaches.Class 
}
assert inv6_Repaired {
    inv6[] iff inv6_OK[]
}