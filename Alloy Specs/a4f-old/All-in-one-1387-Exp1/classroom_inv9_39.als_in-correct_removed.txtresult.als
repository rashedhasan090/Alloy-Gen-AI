There is a bug in the following line of code in pred inv9:
--\tall c:Class | lone Teaches.c & Teacher --correct

The double dash "--" comments out the entire line of code, making it ineffective. The line should be fixed by removing the double dash:

'/* No class has more than a teacher assigned. */\n', 'pred inv9 {\n', '\tall c:Class | lone Teaches.c & Teacher --correct\n', '}\n',