pred inv14_OK {
  all c : Class | all s : Student | s in (c.(Groups.Group) -> Tutors[Teaches[c]]) 
}