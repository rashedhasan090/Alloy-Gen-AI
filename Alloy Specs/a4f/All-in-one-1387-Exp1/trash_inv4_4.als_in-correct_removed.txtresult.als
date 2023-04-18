The bug in this specification is in the predicate inv4 where the keyword "--" is used instead of "not" for negation. The corrected predicate is:

pred inv4 {
    not (Protected & Trash)
}