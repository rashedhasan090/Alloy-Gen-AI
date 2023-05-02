Fixed code for inv9:

pred inv9_OK {
  all c:Class | lone t:Teacher | t in Teaches.c
}