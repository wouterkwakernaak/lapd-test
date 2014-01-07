module Queries::ExceptionQuery

import ValueIO;
import LAPD;
import lang::java::m3::AST;
import Benchmarks::Util;
import IO;

public void rascalException() {
	set[Declaration] asts = createAstsFromDirectory(smallAnalysisProjectLoc, true);
	findCatches(asts);
}

public void compare() {
	set[Statement] c = exceptionCypher();
	set[Statement] r = findExceptionCatches(createAstsFromDirectory(smallAnalysisProjectLoc, true));
	println(c == r);
	int countc = 0;
	int countr = 0;
	for (x <- c)
		countc += 1;
	for (y <- r)
		countr += 1;
	println(countc);
	println(countr);
}

public set[Statement] exceptionCypher() {
	set[Statement] stmts = executeQuery("start s=node:nodes(node = \'catch\') match s-[:HEAD]-\>()-[:HEAD]-\>()-[:HEAD]-\>()-[:HEAD]-\>e where e.str = \'Exception\' return s", #set[Statement], true);
	return stmts;
}

private set[Statement] findExceptionCatches(set[Declaration] asts) {
	stmts = for(/\catch(\parameter(simpleType(simpleName("Exception")), x, y), z) := asts)
			append \catch(\parameter(simpleType(simpleName("Exception")), x, y), z);
	return {s | s <- stmts};
}

//private set[Statement] findCatches() {
//	set[Declaration] asts = createAstsFromDirectory(smallAnalysisProjectLoc, true);
//	stmts = for(/\catch(x, y) := asts)
//		append \catch(x, y);
//	return {s | s <- stmts};
//}