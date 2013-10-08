module NodeTestCases

import LAPD;

public test bool testNodeCases() {
	return assert testNode() && testNodeWithAnnotation() && testNodeWithADT() && testNodeWithAnnotatedADT();
}

private test bool testNode() {
	node expected = "name"("random", true);
	str id = generateRandomId();
	write(id, expected);
	node actual = read(id, #node);
	return assert expected == actual;
}

anno int node @ someAnnotation;

private test bool testNodeWithAnnotation() {
	node expected = "xyz"("random", true);
	expected @ someAnnotation = 824;
	str id = generateRandomId();
	write(id, expected);
	node actual = read(id, #node);
	return assert expected == actual;
}

data Bool = tt() | ff() | conj(Bool L, Bool R)  | disj(Bool L, Bool R);

private test bool testNodeWithADT() {
	node expected = "%$#@"("random", conj(tt(), ff()));
	str id = generateRandomId();
	write(id, expected);
	node actual = read(id, #node);
	return assert expected == actual;
}

private test bool testNodeWithAnnotatedADT() {
	Bool b = conj(tt(), ff());
	b @ someAnnotation = 55;
	node expected = "/\\"(b, true);
	str id = generateRandomId();
	write(id, expected);
	node actual = read(id, #node);
	return assert expected == actual;
}