pred inv13_OK {
  all p : Person | (p in Teacher implies p in Tutors) and (p in Student implies p not in Tutors) 
}