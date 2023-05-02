There was a missing condition in the original inv11 predicate. The fixed code for inv11 is:

/* A class only has groups if it has a teacher assigned. */
pred inv11 {
    all c:Class | some t:Teacher |
        all g:Group | (c -> t -> g in Groups) implies c -> g in (Teacher.Teaches).Groups
}

The rest of the code remains the same.