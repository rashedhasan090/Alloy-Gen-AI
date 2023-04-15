The bug is in the Contains predicate. The implication should be reversed: if there is no node with the element x, then the result should be False. To fix it, change the implication to a biconditional and swap the True and False values:

pred Contains(This: List, x: Int, result: Boolean) {
  RepOk[This]
  // Fixed:
  result = (some n: This.header.*link | n.elem = x ) <=> True
}

With this fix, the repair_assert_1 and repair_pred_1 assertions both pass.