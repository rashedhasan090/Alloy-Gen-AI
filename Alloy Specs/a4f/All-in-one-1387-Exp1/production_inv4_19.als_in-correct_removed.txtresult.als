The bug in the specification is in the predicate inv4. The correct version, which checks that all parts required by a component are assembled in a previous position, is:

pred inv4 { // The parts required by a component cannot be assembled in a later position
   all c:Component | c.parts.cposition in c.cposition.*prev 
}