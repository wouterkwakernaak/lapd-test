module Queries::ReachabilityQuery

import LAPD;
import lang::java::jdt::m3::Core;
import Benchmarks::Util;
import IO;
import String;
import Queries::Util;

private loc theMethod = |java+method:///smallsql/database/SSStatement/execute(java.lang.String)|;

public set[loc] reachabilityRascal() {
	rel[loc from, loc to] callGraph = createCallGraph()+;
	set[loc] reachableMethods = {call.to | tuple[loc from, loc to] call <- callGraph, call.from == theMethod};
	
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

public set[loc] reachabilityCypher() {
	set[loc] reachableMethods = executeQuery("start x=node:nodes(loc = \'|" + theMethod.uri + "|\'), y=node(*) match p = shortestPath(x-[:TO*]-\>y) where last(p) \<\> x return last(p)", #set[loc], true);
	
	int count = 0;
	for (m <- reachableMethods)
		count += 1;
	println("# of methods reachable: <count>");
	return reachableMethods;
}