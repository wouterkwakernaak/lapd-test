module ListTestCases

import LAPD;

public test bool testListCases() {
	return testEmptyList() && testValueList();
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