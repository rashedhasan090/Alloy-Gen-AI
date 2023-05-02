pred inv12_OK {
  all x : Teacher, y : Class | y in x.Teaches implies some z : Group | y -> x -> z in Groups
}