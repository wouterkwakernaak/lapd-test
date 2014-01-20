module Queries::ReachabilityQuery

import LAPD;
import lang::java::jdt::m3::Core;
import Benchmarks::Util;
import IO;
import String;
import Queries::Util;

public set[loc] reachabilityJava(loc method) {
	return executeJavaQuery(3, "|" + method.uri + "|", #set[loc]);
}

public set[loc] reachabilityRascal(loc method, rel[loc from, loc to] callGraph) {
	rel[loc from, loc to] tc = callGraph+;
	set[loc] reachableMethods = {call.to | tuple[loc from, loc to] call <- tc, call.from == method};
	return reachableMethods;
}

public set[loc] reachabilityCypher(loc method) {
	set[loc] reachableMethods = executeQuery("start x=node:nodes(loc = \'|" + method.uri + "|\'), y=node(*) match p = shortestPath(x-[:TO*]-\>y) where last(p) \<\> x return last(p)", #set[loc], true);
	return reachableMethods;
}