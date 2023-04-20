The bug is in the fact IGNORE. The constraint "List.header.*link = Node" needs to be modified to "List.header.*link in Node". The corrected fact is:

fact IGNORE {
  one List
  List.header.*link in Node
}