The bug is in the crossRiver predicate - there is a missing conjunction in the second disjunct of the if-else statement. Specifically, there should be an "and" between "( from' = from - Farmer - item )" and "to' = to - to.eats + Farmer + item". 

Here's the fixed crossRiver predicate:

pred crossRiver [from, from', to, to': set Object] {
  // either the Farmer takes no items
  ( from' = from - Farmer &&
    to' = to - to.eats + Farmer ) ||
  // or the Farmer takes one item
    (from' = from - Farmer - item &&
    to' = to - to.eats + Farmer + item )
}