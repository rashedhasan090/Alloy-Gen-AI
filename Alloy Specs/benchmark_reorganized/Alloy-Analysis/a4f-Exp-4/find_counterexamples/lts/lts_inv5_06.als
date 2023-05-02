
Fixed code for inv6 predicate:

pred inv6 {
    all e:Event | some s1,s2:State | (s1.trans[e] = s2) and (s1 != s2)
}