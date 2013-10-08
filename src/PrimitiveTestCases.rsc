module PrimitiveTestCases

import LAPD;
import DateTime;

public test bool testPrimitiveCases() {
	return assert testBoolean() && testInteger() && testString()
	&& testReal() && testRational() && testDateTime() && testSourceLocation() 
	&& testValue() && testNumber();
}

private test bool testBoolean() {
	bool expected = true;
	str id = generateRandomId();
	write(id, expected);
	bool actual = read(id, #bool);
	return assert expected == actual;
}

private test bool testInteger() {
	int expected = 7;
	str id = generateRandomId();
	write(id, expected);
	int actual = read(id, #int);
	return assert expected == actual;
}

private test bool testString() {
	str expected = "this is a test";
	str id = generateRandomId();
	write(id, expected);
	str actual = read(id, #str);
	return assert expected == actual;
}

private test bool testReal() {
	real expected = 0.987056;
	str id = generateRandomId();
	write(id, expected);
	real actual = read(id, #real);
	return assert expected == actual;
}

private test bool testRational() {
	rat expected = 37r55;
	str id = generateRandomId();
	write(id, expected);
	rat actual = read(id, #rat);
	return assert expected == actual;
}

private test bool testDateTime() {
	datetime expected = now();
	str id = generateRandomId();
	write(id, expected);
	datetime actual = read(id, #datetime);
	return assert expected == actual;
}

private test bool testSourceLocation() {
	loc expected = |std://demo/basic/Hello.rsc|;
	str id = generateRandomId();
	write(id, expected);
	loc actual = read(id, #loc);
	return assert expected == actual;
}

private test bool testValue() {
	value expected = 3;
	str id = generateRandomId();
	write(id, expected);
	value actual = read(id, #value);
	return assert expected == actual;
}

private test bool testNumber() {
	num expected = 3.5;
	str id = generateRandomId();
	write(id, expected);
	num actual = read(id, #num);
	return assert expected == actual;
}

