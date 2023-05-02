There is a missing closing brace in the acyclic predicate. It should be:

pred acyclic {
 all a:Node | a not in a.^adj 
}