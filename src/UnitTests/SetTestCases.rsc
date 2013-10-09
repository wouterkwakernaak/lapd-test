module UnitTests::SetTestCases

import LAPD;

public test bool testSetCases() {
	return testEmptySet() && testSet() && testRelation();
}

public test bool testEmptySet() {
	set[void] expected = {};
	str id = generateUniqueId();
	write(id, expected);
	set[void] actual = read(id, #set[void]);
	return assert expected == actual;
}

public test bool testSet() {
	set[int] expected = {1, 3, 5, 7, 9};
	str id = generateUniqueId();
	write(id, expected);
	set[int] actual = read(id, #set[int]);
	return assert expected == actual;
}

public test bool testRelation() {
	rel[real, str] expected = {<1.1, "one">, <2.0, "two">};
	str id = generateUniqueId();
	write(id, expected);
	rel[real, str] actual = read(id, #rel[real, str]);
	return assert expected == actual;
}