module Queries::ReachabilityQuery

import LAPD;
import lang::java::jdt::m3::Core;
import Benchmarks::Util;
import IO;
import String;

private str theMethod = "/smallsql/database/SSStatement/execute(java.lang.String)";

private rel[str from, str to] createCallGraph() {
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
	set[str] reachableMethods = {call.to | tuple[str from, str to] call <- callGraph, call.from == theMethod};
	
	int count = 0;
	for (m <- reachableMethods)
		count += 1;
	println("# of methods reachable: <count>");
	return reachableMethods;
}

public void compare() {
	a = reachabilityRascal();
	b = reachabilityCypher();
	println(b - a);
}

public set[str] reachabilityCypher() {
	set[str] reachableMethods = executeQuery("start x=node:nodes(str = \'" + theMethod + "\'), y=node(*) match p = shortestPath(x-[:NEXT_ELEMENT*]-\>y) where last(p) \<\> x return last(p)", #set[str], true);
	
	int count = 0;
	for (m <- reachableMethods)
		count += 1;
	println("# of methods reachable: <count>");
	return reachableMethods;
}