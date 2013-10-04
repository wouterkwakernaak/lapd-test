module AllTestCases

import PrimitiveTestCases;
import ADTTestCases;

public test bool testAll() {
	return assert testPrimitiveCases() && testADTCases();
}