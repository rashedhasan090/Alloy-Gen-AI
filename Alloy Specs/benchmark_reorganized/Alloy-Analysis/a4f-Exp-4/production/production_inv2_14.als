
pred inv4_OK {
  all c:Component | c.parts.cposition in c.cposition.*prev.rposition 
}

Here, rposition has been added after prev to correctly check if the parts required by a component can be assembled in a later position.