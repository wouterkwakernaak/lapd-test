module UnitTests::TupleTestCases

import LAPD;

public test bool testTupleCases() {
	return testTuple() && testNestedTuple() && testTypeParameters();
}

public test bool testTuple() {
	tuple[bool a, str b, int c] expected = <false, "hello", 92>;
	str id = generateUniqueId();
	write(id, expected);
	tuple[bool a, str b, int c] actual = read(id, #tuple[bool, str, int]);
	return assert expected == actual;
}

public test bool testNestedTuple() {
	tuple[real, tuple[str, int]] expected = <1.53, <"world", 33>>;
	str id = generateUniqueId();
	write(id, expected);
	tuple[real, tuple[str, int]] actual = read(id, #tuple[real, tuple[str, int]]);
	return assert expected == actual;
}

private test bool testTypeParameters() {
	tuple[&A, &B] expected = <1, "one">;
	str id = generateUniqueId();
	write(id, expected);
	tuple[&A, &B] actual = read(id, #tuple[&A, &B]);
	return assert expected == actual;
}