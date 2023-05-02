
/* No class has more than one teacher assigned. */
pred inv9_OK {
  all c:Class | lone t:Teacher | t -> c in Teaches
}