The bug in the specification is in the inv7 predicate. The comment "--" was left in the predicate causing it to be syntactically incorrect. The "--" in the comment should be removed.

Fixed code:

pred inv7 {
  no link.Trash --correct
}