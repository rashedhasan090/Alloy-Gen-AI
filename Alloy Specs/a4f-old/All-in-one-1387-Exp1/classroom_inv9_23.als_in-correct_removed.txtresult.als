pred inv9_OK {
 all c:Class | lone Teaches[c] & Teacher --fixed
}
assert inv9_Repaired {
    inv9[] iff inv9_OK[]
}

--- PerfectOracleCommands
check inv9_Repaired expect 0