module UnitTests::AllTestCases

import UnitTests::PrimitiveTestCases;
import UnitTests::ADTTestCases;
import UnitTests::ListTestCases;
import UnitTests::NodeTestCases;
import UnitTests::TupleTestCases;
import UnitTests::MapTestCases;
import UnitTests::SetTestCases;

public test bool testAll() {
	return assert testPrimitiveCases() && testADTCases() && testListCases() && testNodeCases() 
	&& testTupleCases() && testMapCases() && testSetCases();
}