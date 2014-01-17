module Benchmarks::QueryBenchmark

import Queries::ResursiveMethodsQuery;
import Queries::Util;
import Queries::SwitchQuery;
import util::Benchmark;
import Benchmarks::Util;
import lang::csv::IO;

public void benchmarkRecursiveMethodsQuery() {
	int runs = 5;
	rel[loc from, loc to] callGraph = createCallGraph();
	insertCallGraph("callGraph", callGraph);	
	rel[str query, list[int] time] results = {<"java", measureQueryLapd(runs, recursiveMethodsJava)>, 
	<"cypher", measureQueryLapd(runs, recursiveMethodsCypher)>, 
	<"rascal", measureQueryLapd(callGraph, runs, recursiveMethodsRascal)>};
	loc resultsFile = grabBenchmarkResultsLoc("hsqldb-recursive-methods-query");
	writeCSV(results, resultsFile);
}

// needs an inserted set of java ASTs
public void benchmarkSwitchQuery() {
	int runs = 5;
	str id = largeJavaPrjId;
	loc file = grabBinaryFileLoc();
	rel[str query, int time] results = {<"java", measureQueryLapd(runs, switchJavaQuery)>, 
	<"hybrid", measureQueryLapd(runs, switchHybrid)>, 
	<"full lapd", measureQueryLapd(id, runs, switchLoadFullValue)>,
	<"full binary", measureQueryLapd(file, runs, switchLoadFullValue)>};
	loc resultsFile = grabBenchmarkResultsLoc("switch-query");
	writeCSV(results, resultsFile);
}

private list[int] measureQueryLapd(&T param, int runs, set[value](&T param) queryFunc)
{	
	int total = 0;
	list[int] result = [];
	for (n <- [0..runs]) {
		begin = realTime();
		queryFunc(param);	
		used = realTime() - begin;
		result += used;
		total += used;
	}
	avg = total / runs;
	result += avg;
	return result;
}

private list[int] measureQueryLapd(int runs, set[value]() queryFunc)
{	
	int total = 0;
	list[int] result = [];
	for (n <- [0..runs]) {
		begin = realTime();
		queryFunc();	
		used = realTime() - begin;
		result += used;
		total += used;
	}
	avg = total / runs;
	result += avg;
	return result;
}