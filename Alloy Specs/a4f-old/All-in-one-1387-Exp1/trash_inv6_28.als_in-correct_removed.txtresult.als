The bug in the specification is in the predicate inv6. The comment symbol "--" is missing at the beginning of the predicate. The fixed code is:

/* A file links to at most one file. */
pred inv6 {
    -- ~link . link in iden --correct
    all f: File | lone f.link
}

Note that I have also modified the predicate to use the "lone" quantifier instead of the negation of "link . link in iden", which is equivalent but more intuitive.