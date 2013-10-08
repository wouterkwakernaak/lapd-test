module ListTestCases

import LAPD;

public test bool testListCases() {
	return testEmptyList() && testValueList() && testListRelation();
}

private test bool testEmptyList() {
	list[void] expected = [];
	str id = generateRandomId();
	write(id, expected);
	list[void] actual = read(id, #list[void]);
	return assert expected == actual;
}

private test bool testValueList() {
	list[value] expected = [4, true, "random"];
	str id = generateRandomId();
	write(id, expected);
	list[value] actual = read(id, #list[value]);
	return assert expected == actual;
}

private test bool testListRelation() {
	list[rel[int, int]] expected = [{<1,2>, <2,3>},{<3,4>, <4,5>}];
	str id = generateRandomId();
	write(id, expected);
	list[rel[int, int]] actual = read(id, #list[rel[int, int]]);
	return assert expected == actual;
}