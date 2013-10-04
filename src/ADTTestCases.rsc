module ADTTestCases

import LAPD;

public test bool testADTCases() {
	return assert testADT_1() && testADT_2() && testADT_3() && testADT_4();
}

data Bool = tt() | ff() | conj(Bool L, Bool R)  | disj(Bool L, Bool R);
data CrazyADT = x() | y(str crazyStr, int crazyInt);

public test bool testADT_1() {
	Bool expected = tt();
	str id = generateRandomId();
	write(id, expected);
	Bool actual = read(id, #Bool);
	return assert expected == actual;
}

public test bool testADT_2() {
	Bool expected = conj(tt(), ff());
	str id = generateRandomId();
	write(id, expected);
	Bool actual = read(id, #Bool);
	return assert expected == actual;
}

public test bool testADT_3() {
	CrazyADT expected = y("hello, world", 9);
	str id = generateRandomId();
	write(id, expected);
	CrazyADT actual = read(id, #CrazyADT);
	return assert expected == actual;
}

public test bool testADT_4() {
	Bool b1 = ff();
	Bool b2 = disj(conj(tt(), ff()), ff());	
	list[Bool] expected = [b1, b2];
	str id = generateRandomId();
	write(id, expected);
	list[Bool] actual = read(id, #list[Bool]);
	return assert expected == actual;
}