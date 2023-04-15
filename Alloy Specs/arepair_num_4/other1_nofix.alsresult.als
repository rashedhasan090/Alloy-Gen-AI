The bug in this specification is that the fact statement permits any group to be located in the seclab room, including groups other than alas and peds. To fix this, we need to use an only statement to restrict the located_in set of seclab to only contain alas and peds.

The fixed Alloy specification is:

//people
sig Person {
   member_of : some Group
}

pred CanEnter(p: Person, r:Room) {
    p.member_of in r.located_in
}

// groups 
sig Group {}

one sig alas extends Group {}  
one sig peds extends Group {}

//rooms
sig Room {
  located_in: set Group
}

one sig seclab extends Room {}

// fix the fact to restrict located_in set of seclab to only contain alas and peds
fact {
  seclab.located_in = only alas + peds
}

// assertion
assert repair_assert_1 {
   all p : Person | CanEnter[p, seclab] implies alas in p.member_of or peds in p.member_of
}

check repair_assert_1

pred repair_pred_1{
   all p : Person | CanEnter[p, seclab] implies alas in p.member_of or peds in p.member_of
}

run repair_pred_1