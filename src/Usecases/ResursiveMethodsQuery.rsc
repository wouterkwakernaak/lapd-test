module Usecases::ResursiveMethodsQuery

import IO;
import ValueIO;
import LAPD;
import lang::java::jdt::m3::Core;

public set[value] recursiveMethodsHybrid(str id) {
	rel[loc from, loc to] invocations = executeQuery("start n=node:nodes(id = \'" + id + "\') match n-[:ANNOTATION]-\>anno where anno.annotation = \'methodInvocation\' return anno", #rel[loc from, loc to], false);
	return findRecursiveMethods(invocations);
}

public set[value] recursiveMethodsJavaQuery(str id) {
	return executeJavaQuery(1, id);
}

public set[value] recursiveMethodsLoadFullValue(str id) {
	M3 m3 = read(id, #M3);
	return findRecursiveMethods(m3@methodInvocation);	
}

public set[value] recursiveMethodsLoadFullValue(loc file) {
	M3 m3 = readBinaryValueFile(#M3, file);
	return findRecursiveMethods(m3@methodInvocation);	
}

private set[value] findRecursiveMethods(rel[loc from, loc to] invocations) {
	l = for (tuple[loc from, loc to] invocation <- invocations) {
		str methodFrom = invocation.from.path;
		str methodTo = invocation.to.path;	
		if (/<methodTo>/ := methodFrom)
			append invocation.to;
	}
	return {x | x <- l};
}