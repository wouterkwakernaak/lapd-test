module Queries::ResursiveMethodsQuery

import ValueIO;
import IO;
import LAPD;
import lang::java::jdt::m3::Core;
import Queries::Util;

public set[loc] recursiveMethodsJavaQuery() {
	return executeJavaQuery(1, "", #set[loc]);
}
//
//public set[loc] recursiveMethodsLoadFullValue(str id) {
//	M3 m3 = read(id, #M3);
//	return findRecursiveMethods(m3@methodInvocation);	
//}
//
//public set[loc] recursiveMethodsLoadFullValue(loc file) {
//	M3 m3 = readBinaryValueFile(#M3, file);
//	return findRecursiveMethods(m3@methodInvocation);	
//}

public void compareRecursive() {
	a = recursiveMethodsRascal();
	b = recursiveMethodsCypher();
	c = recursiveMethodsJavaQuery();
	println(a - b);
	println(b - a);
	println(a - c);
	println(c - a);
}
public set[loc] recursiveMethodsRascal() {
	rel[loc from, loc to] invocations = createCallGraph();
	return {invocation.from | tuple[loc from, loc to] invocation <- invocations, invocation.from == invocation.to};
}

public set[loc] recursiveMethodsCypher() {
	return executeQuery("start x=node(*) match x-[:TO]-\>x return x", #set[loc], true);
}