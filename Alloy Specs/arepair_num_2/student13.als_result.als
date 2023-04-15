The bug in the specification is at the end of the fact IGNORE. It should be 'List.header.*link = Node' instead of 'List.header.*link = Node'. This means that all nodes should be reachable from the list header, but the specification only requires that all nodes be reachable from the header or from a previous node in the list. 

The corrected fact IGNORE is: 

fact IGNORE {
  one List
  Node in List.header.*link
}