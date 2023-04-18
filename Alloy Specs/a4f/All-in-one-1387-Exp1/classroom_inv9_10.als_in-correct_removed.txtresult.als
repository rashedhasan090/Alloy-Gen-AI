pred inv9_OK {
  all c:Class | lone c.Teaches.Teacher 
}

check inv9_OK expect 0