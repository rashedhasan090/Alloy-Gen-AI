pred inv9_OK {\n', '\tall c:Class | lone c.Teaches & Teacher --correct\n', '}\n', '\n', 'assert inv9_Repaired {\n', '    inv9[] iff inv9_OK[]\n', '}\n', '\n', 'check inv9_Repaired expect 0\n']