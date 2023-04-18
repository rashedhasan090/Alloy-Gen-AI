The bug in this specification is in line 41 where the comment says "--" which makes the predicate 'inv10' useless. To fix this, remove the "--" in line 41 to have the following corrected code:

/* For every class, every student has a group assigned. */
pred inv10 {
    all c:Class, s:Student | some s.(c.Groups)
}