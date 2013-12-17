module Queries::ReachabilityQuery

import LAPD;
import lang::java::jdt::m3::Core;
import Benchmarks::Util;
import IO;
import String;

public rel[str from, str to] createCallGraph() {
	M3 m3 = createM3FromEclipseProject(smallAnalysisProjectLoc);
	callGraphList = for(tuple[loc from, loc to] invocation <- m3@methodInvocation) {
		str pathFrom = invocation.from.path;
		str pathTo = invocation.to.path;
		if(!endsWith(pathFrom, ")"))
			pathFrom = substring(pathFrom, 0, findLast(pathFrom, "/"));
		append <pathFrom, pathTo>;
	}
	return callGraph = {c | c <- callGraphList};
}

public void insertCallGraph() {
	write("callGraph", createCallGraph());
}

public set[str] reachabilityRascal() {
	rel[str from, str to] callGraph = createCallGraph()+;
	set[str] reachableMethods = {call.to | tuple[str from, str to] call <- callGraph, call.from == "/smallsql/database/SSStatement/execute(java.lang.String)"};
	int count = 0;
	for (m <- reachableMethods)
		count += 1;
	println("# of methods reachable: <count>");
	return reachableMethods;
}

public set[str] reachabilityCypher(str id) {
	//rel[loc from, loc to] invocations = executeQuery("start n=node:nodes(id = \'" + id + "\') match n-[:ANNOTATION]-\>anno where anno.annotation = \'methodInvocation\' return anno", #rel[loc from, loc to], false);
	//return findRecursiveMethods(invocations);
}