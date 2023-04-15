The bug is in the predicate Count. The disjunction (||) should be a conjunction (&&) in the definition of result.

Fixed version of the predicate:

pred Count(This: List, x: Int, result: Int) {
    RepOk[This]
    result = #{n: Node | n in This.header.*link && n.elem = x}
}