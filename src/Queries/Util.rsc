module Queries::Util

import LAPD;
import lang::java::jdt::m3::Core;
import Benchmarks::Util;
import String;
import IO;

public rel[loc from, loc to] createCallGraph() {
	M3 m3 = createM3FromEclipseProject(largeAnalysisProjectLoc);
	callGraphList = for(tuple[loc from, loc to] invocation <- m3@methodInvocation) {
		str pathFrom = invocation.from.path;
		str pathTo = invocation.to.path;
		if(!endsWith(pathFrom, ")"))
			pathFrom = substring(pathFrom, 0, findLast(pathFrom, "/"));
		append <|java+method:///| + pathFrom, |java+method:///| + pathTo>;
	}
	return callGraph = {c | c <- callGraphList};
}

public void insertCallGraph() {
	write("callGraph", createCallGraph());
}

public void insertCallGraph(str id) {
	write(id, createCallGraph());
}

public void insertCallGraph(str id, rel[loc from, loc to] callGraph) {
	write(id, callGraph);
}