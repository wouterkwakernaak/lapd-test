module Benchmarks::QueryBenchmark
// Benchmarks in this module assume that values are already inserted.

import Usecases::ResursiveMethodsQuery;
import util::Benchmark;
import Benchmarks::Util;
import lang::csv::IO;

public void runRecursiveMethodsQuery() {
	int runs = 10;
	str id = smallJavaPrjId;
	loc file = grabBinaryFileLoc();
	rel[str query, int time] results = {<"java", measureQueryLapd(id, runs, recursiveMethodsJavaQuery)>, 
	<"hybrid", measureQueryLapd(id, runs, recursiveMethodsHybrid)>, 
	<"full lapd", measureQueryLapd(id, runs, recursiveMethodsLoadFullValue)>,
	<"full binary", measureQueryLapd(file, runs, recursiveMethodsLoadFullValue)>};
	loc resultsFile = grabBenchmarkResultsLoc("recursive-methods-query");
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