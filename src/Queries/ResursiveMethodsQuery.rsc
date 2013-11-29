module Queries::ResursiveMethodsQuery

import ValueIO;
import IO;
import LAPD;
import lang::java::jdt::m3::Core;

public set[loc] recursiveMethodsHybrid(str id) {
	rel[loc from, loc to] invocations = executeQuery("start n=node:nodes(id = \'" + id + "\') match n-[:ANNOTATION]-\>anno where anno.annotation = \'methodInvocation\' return anno", #rel[loc from, loc to], false);
	return findRecursiveMethods(invocations);
}

public set[loc] recursiveMethodsJavaQuery(str id) {
	return executeJavaQuery(1, id, #set[loc]);
}

public set[loc] recursiveMethodsLoadFullValue(str id) {
	M3 m3 = read(id, #M3);
	return findRecursiveMethods(m3@methodInvocation);	
}

public set[loc] recursiveMethodsLoadFullValue(loc file) {
	M3 m3 = readBinaryValueFile(#M3, file);
	return findRecursiveMethods(m3@methodInvocation);	
}

private set[loc] findRecursiveMethods(rel[loc from, loc to] invocations) {
	methodList = for(tuple[loc from, loc to] invocation <- invocations) {
		str methodFrom = invocation.from.path;
		str methodTo = invocation.to.path;
		if (/<methodTo>/ := methodFrom)
			append invocation.to;
	}
	return {m | m <- methodList};
}