pred inv14_OK {
      all s : Student, c : Class | some t : Teacher  | (t -> s in Tutors and t -> c in Teaches) implies s -> c in Groups[t]
}
