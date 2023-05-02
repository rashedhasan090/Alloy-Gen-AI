There is an error in the definition of inv3. Specifically, the implication in the expression "w1 in u.profile && w in u.profile implies w.ids != w1.ids" is incorrect. This leads to spurious counterexamples when checking the invariant. The correct predicate is:

pred inv3_OK {
    all u:User, w1:Work, w2:Work | w1 != w2 && w1 in u.profile && w2 in u.profile && w1.source = w2.source 
        implies no ids:Id | ids in w1.ids && ids in w2.ids
}

Here, we remove the implication and make it a conjunction that expresses the fact that any two works in the same profile with the same source should not share any identifiers. We also quantify over the set of ids instead of the individual ids for clarity.