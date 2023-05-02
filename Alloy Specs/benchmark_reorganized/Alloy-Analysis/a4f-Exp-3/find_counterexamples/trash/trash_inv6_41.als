sig File {
  link: lone File,
  home: one Home
}

sig Home {
  contents: set File
}

pred inv1 {
  all h: Home | no h.contents.link
}

pred inv2 {
  all h: Home | all f: h.contents | f.link.home = h
}

pred inv3 {
  all h: Home | no h.contents.link.home = h
}

pred inv4 {
  all f: File | no f.link in f.home.contents
}

pred inv5 {
  all h: Home | one h.contents.link implies h.contents.link in h.contents
}

run {
  // All homes have a file with a self--link
  all h: Home | some f: h.contents | f.link = f
  
  // Add another file to each home
  all h: Home | some f: File | f not in h.contents && f.home = h
  
  // All homes have at least two files
  all h: Home | #h.contents >= 2
  
  // Fix inv5 by making link into a one--to--one relation
  inv5'[] := link in File lone-> File lone
  
  // Check all invariants
  assert inv1[] and inv2[] and inv3[] and inv4[] and inv5'[]
} for 5
