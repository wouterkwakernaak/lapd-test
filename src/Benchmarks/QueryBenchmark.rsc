module Benchmarks::QueryBenchmark
// Benchmarks in this module assume that values are already inserted.

import Queries::ResursiveMethodsQuery;
import Queries::SwitchQuery;
import util::Benchmark;
import Benchmarks::Util;
import lang::csv::IO;

// needs an inserted java M3 model
public void runRecursiveMethodsQuery() {
	int runs = 1;
	str id = smallJavaPrjId;
	loc file = grabBinaryFileLoc();
	rel[str query, int time] results = {<"java", measureQueryLapd(id, runs, recursiveMethodsJavaQuery)>, 
	<"hybrid", measureQueryLapd(id, runs, recursiveMethodsHybrid)>, 
	<"full lapd", measureQueryLapd(id, runs, recursiveMethodsLoadFullValue)>,
	<"full binary", measureQueryLapd(file, runs, recursiveMethodsLoadFullValue)>};
	loc resultsFile = grabBenchmarkResultsLoc("recursive-methods-query");
	writeCSV(results, resultsFile);
}

// needs an inserted set of java ASTs
public void runSwitchQuery() {
	int runs = 2;
	str id = largeJavaPrjId;
	loc file = grabBinaryFileLoc();
	rel[str query, int time] results = {<"java", measureQueryLapd(runs, switchJavaQuery)>, 
	<"hybrid", measureQueryLapd(runs, switchHybrid)>, 
	<"full lapd", measureQueryLapd(id, runs, switchLoadFullValue)>,
	<"full binary", measureQueryLapd(file, runs, switchLoadFullValue)>};
	loc resultsFile = grabBenchmarkResultsLoc("switch-query");
	writeCSV(results, resultsFile);
}

public int measureQueryLapd(&T id, int runs, set[value](&T id) queryFunc)
{	
	int total = 0;	
	for (n <- [0..runs]) {
		begin = realTime();
		set[value] result = queryFunc(id);	
		used = realTime() - begin;
		total += used;
	}
	avg = total / runs;
	return avg;
}

public int measureQueryLapd(int runs, set[value]() queryFunc)
{	
	int total = 0;	
	for (n <- [0..runs]) {
		begin = realTime();
		set[value] result = queryFunc();	
		used = realTime() - begin;
		total += used;
	}
	avg = total / runs;
	return avg;
}