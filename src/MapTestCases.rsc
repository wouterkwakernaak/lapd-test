module MapTestCases

import LAPD;

public test bool testMapCases() {
	return testMap() && testNestedMap();
}

public test bool testMap() {
	map[int, str] expected = (1: "one", 2: "two", 3: "three");
	str id = generateRandomId();
	write(id, expected);
	map[int, str] actual = read(id, #map[int, str]);
	return assert expected == actual;
}

public test bool testNestedMap() {
	map[int, map[int, str]] expected = (1: (1: "one", 2: "two"), 2: (3: "three", 4: "four"));
	str id = generateRandomId();
	write(id, expected);
	map[int, map[int, str]] actual = read(id, #map[int, map[int, str]]);
	return assert expected == actual;
}