module TupleTestCases

import LAPD;

public test bool testTupleCases() {
	return testTuple() && testNestedTuple();
}

public test bool testTuple() {
	tuple[bool a, str b, int c] expected = <false, "hello", 92>;
	str id = generateRandomId();
	write(id, expected);
	tuple[bool a, str b, int c] actual = read(id, #tuple[bool, str, int]);
	return assert expected == actual;
}

public test bool testNestedTuple() {
	tuple[real, tuple[str, int]] expected = <1.53, <"world", 33>>;
	str id = generateRandomId();
	write(id, expected);
	tuple[real, tuple[str, int]] actual = read(id, #tuple[real, tuple[str, int]]);
	return assert expected == actual;
}