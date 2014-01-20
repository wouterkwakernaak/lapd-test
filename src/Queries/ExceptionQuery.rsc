module Queries::ExceptionQuery

import ValueIO;
import LAPD;
import lang::java::m3::AST;
import Benchmarks::Util;
import IO;

public set[Statement] exceptionJava() {
	return executeJavaQuery(4, "", #set[Statement]);
}

public set[Statement] exceptionCypher() {
	set[Statement] stmts = executeQuery("start s=node:nodes(node = \'catch\') match s-[:HEAD]-\>()-[:HEAD]-\>()-[:HEAD]-\>()-[:HEAD]-\>e where has(e.str) and e.str = \'Exception\' return s", #set[Statement], true);
	return stmts;
}

public set[Statement] exceptionRascal(set[Declaration] asts) {
	stmts = for(/\catch(\parameter(simpleType(simpleName("Exception")), x, y), z) := asts)
			append \catch(\parameter(simpleType(simpleName("Exception")), x, y), z);
	return {s | s <- stmts};
}