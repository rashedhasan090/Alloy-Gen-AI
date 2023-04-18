There is a comment marking the start of an incomplete predicate inv14 and no comment marking the end. The correct inv14 predicate is:

pred inv14 {
  all s : Person, c : Class, t : Person, g : Group | (c -> s -> g in Groups) and t -> c in Teaches implies t -> s in Tutors
} --correct
}