module AllTestCases

import PrimitiveTestCases;
import ADTTestCases;
import ListTestCases;
import NodeTestCases;
import TupleTestCases;
import MapTestCases;
import SetTestCases;

public test bool testAll() {
	return assert testPrimitiveCases() && testADTCases() && testListCases() && testNodeCases() 
	&& testTupleCases() && testMapCases() && testSetCases();
}