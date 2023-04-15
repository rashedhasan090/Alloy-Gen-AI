The bug in the specification is that the "Key" sig allows any "Employee" to be authorized to open it, not just "Researcher" as intended. To fix this, replace "one Employee" with "one Researcher" in the "Key" sig declaration:

sig Key {
  authorized: one Researcher,
  opened_by: one Room
}