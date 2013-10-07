module NodeTestCases

import LAPD;

public test bool testNodeCases() {
	return assert testNode();
}

private test bool testNode() {
	node expected = "name"("random", true);
	str id = generateRandomId();
	write(id, expected);
	node actual = read(id, #node);
	return assert expected == actual;
}