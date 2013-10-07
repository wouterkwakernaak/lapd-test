module AllTestCases

import PrimitiveTestCases;
import ADTTestCases;
import ListTestCases;
import NodeTestCases;

public test bool testAll() {
	return assert testPrimitiveCases() && testADTCases() && testListCases() && testNodeCases();
}