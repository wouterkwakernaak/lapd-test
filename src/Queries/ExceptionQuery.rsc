module Queries::ExceptionQuery

import ValueIO;
import LAPD;
import lang::java::m3::AST;
import Benchmarks::Util;
import IO;

public void compareException() {
	set[Declaration] asts = executeQuery("start n = node:nodes(id = \'smallsql\') return n", #set[Declaration], false);
	set[Statement] a = exceptionCypher();
	set[Statement] b = exceptionRascal(asts);
	set[Statement] c = exceptionJava();
	println(a - b);
	println(b - a);
	println(a - c);
	println(c - a);
}

public set[Statement] exceptionJava() {
	return executeJavaQuery(4, "", #set[Statement]);
}

public set[Statement] exceptionCypher() {
	set[Statement] stmts = executeQuery("start s=node:nodes(node = \'catch\') match s-[:HEAD]-\>()-[:HEAD]-\>()-[:HEAD]-\>()-[:HEAD]-\>e where e.str = \'Exception\' return s", #set[Statement], true);
	return stmts;
}

private set[Statement] exceptionRascal(set[Declaration] asts) {
	stmts = for(/\catch(\parameter(simpleType(simpleName("Exception")), x, y), z) := asts)
			append \catch(\parameter(simpleType(simpleName("Exception")), x, y), z);
	return {s | s <- stmts};
}