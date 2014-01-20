module Benchmarks::QueryBenchmark

import Queries::ResursiveMethodsQuery;
import Queries::ReachabilityQuery;
import Queries::Util;
import Queries::SwitchQuery;
import Queries::ExceptionQuery;
import util::Benchmark;
import Benchmarks::Util;
import lang::csv::IO;
import lang::java::m3::AST;
import LAPD;

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

public void benchmarkReachabilityQuery() {
	loc smallSqlMethod = |java+method:///smallsql/database/SSStatement/execute(java.lang.String)|;
	loc hsqldbMethod = |java+method:///org/hsqldb/StatementCommand/execute(org.hsqldb.Session)|;
	int runs = 5;
	rel[loc from, loc to] callGraph = createCallGraph();
	insertCallGraph("callGraph", callGraph);	
	rel[str query, list[int] time] results = {<"java", measureQueryLapd(hsqldbMethod, runs, reachabilityJava)>, 
	<"cypher", measureQueryLapd(hsqldbMethod, runs, reachabilityCypher)>, 
	<"rascal", measureQueryLapd(hsqldbMethod, callGraph, runs, reachabilityRascal)>};
	loc resultsFile = grabBenchmarkResultsLoc("hsqldb-reachability-query");
	writeCSV(results, resultsFile);
}

public void benchmarkSwitchQuery() {
	int runs = 5;
	set[Declaration] asts = executeQuery("start n = node:nodes(id = \'smallsql\') return n", #set[Declaration], false);
	rel[str query, list[int] time] results = {<"java", measureQueryLapd(runs, switchJava)>, 
	<"cypher", measureQueryLapd(runs, switchCypher)>, 
	<"rascal", measureQueryLapd(asts, runs, switchRascal)>};
	loc resultsFile = grabBenchmarkResultsLoc("hsqldb-switch-query");
	writeCSV(results, resultsFile);
}

public void benchmarkExceptionQuery() {
	int runs = 5;
	set[Declaration] asts = executeQuery("start n = node:nodes(id = \'smallsql\') return n", #set[Declaration], false);
	rel[str query, list[int] time] results = {<"java", measureQueryLapd(runs, exceptionJava)>, 
	<"cypher", measureQueryLapd(runs, exceptionCypher)>, 
	<"rascal", measureQueryLapd(asts, runs, exceptionRascal)>};
	loc resultsFile = grabBenchmarkResultsLoc("hsqldb-exception-query");
	writeCSV(results, resultsFile);
}

private list[int] measureQueryLapd(&T1 param1, &T2 param2, int runs, set[value](&T1 param1, &T2 param2) queryFunc)
{	
	int total = 0;
	list[int] result = [];
	for (n <- [0..runs]) {
		begin = realTime();
		queryFunc(param1, param2);	
		used = realTime() - begin;
		result += used;
		total += used;
	}
	avg = total / runs;
	result += avg;
	return result;
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