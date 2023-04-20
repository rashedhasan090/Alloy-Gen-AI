The bug in this specification is in the inv5 predicate. The correct code for inv5 is:
```
/* All unprotected files are deleted. */
pred inv5 {
  all f: File - Protected |
    f in Trash
}
```