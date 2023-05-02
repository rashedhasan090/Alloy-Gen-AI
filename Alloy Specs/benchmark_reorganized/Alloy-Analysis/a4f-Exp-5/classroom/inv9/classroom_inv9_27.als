The fixed code for the bug in inv9 is:

pred inv9_OK {
  all c:Class | lone Teachers.c
}

The corrected predicate states that for all classes only one teacher is assigned.