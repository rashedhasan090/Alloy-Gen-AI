There is a bug in the inv3_OK predicate. The correct predicate is as follows:

pred inv3_OK {
    all w1, w2 : Work, u : User | w1 != w2 and (w1 + w2) in u.profile implies (w1.source != w2.source or no w1.ids & w2.ids)
} 

After fixing the bug, the repaired assertion should pass the checks.