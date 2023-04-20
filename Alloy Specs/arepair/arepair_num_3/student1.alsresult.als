The bug in the specification is in the fact IGNORE. It specifies that List.header.*link should be equal to Node, which is incorrect. It should be equal to the set of all nodes in the list, which can be expressed as the union of all nodes' link sets. The corrected fact is:

fact IGNORE {
  one List
  List.header.*link = Node.link
}

With this correction, the assertions are satisfied.