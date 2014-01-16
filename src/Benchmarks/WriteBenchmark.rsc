module Benchmarks::WriteBenchmark

import Benchmarks::IntegerBenchmark;
import Benchmarks::M3Benchmark;
import Benchmarks::ASTBenchmark;
import Benchmarks::Util;
import lang::csv::IO;
import lang::java::m3::Core;
import lang::java::m3::AST;
import IO;

public void benchIntWrite() {
	int runs = 5;
	int intValue = 7;	
	rel[str store, list[int] time] results = {<"lapd", lapdWrite(runs, intValue, measureLapdIntWrite)>, 
	<"text file", textWrite(runs, intValue, measureTextIntWrite)>, 
	<"binary file", binaryWrite(runs, intValue, measureBinaryIntWrite)>};
	loc file = grabBenchmarkResultsLoc("integer-write-batch");
	writeCSV(results, file);
}

public void benchASTWrite() {
	int runs = 5;
	Declaration ast = createSmallAST();	
	rel[str store, list[int] time] results = {<"lapd", lapdWrite(runs, ast, measureLapdASTWrite)>, 
	<"text file", textWrite(runs, ast, measureTextASTWrite)>, 
	<"binary file", binaryWrite(runs, ast, measureBinaryASTWrite)>};
	loc file = grabBenchmarkResultsLoc("AST-write-batch");
	writeCSV(results, file);
}

public void benchM3Write() {
	int runs = 5;
	M3 m3 = createSmallM3();	
	rel[str store, list[int] time] results = {<"lapd", lapdWrite(runs, m3, measureLapdM3Write)>, 
	<"text file", textWrite(runs, m3, measureTextM3Write)>, 
	<"binary file", binaryWrite(runs, m3, measureBinaryM3Write)>};
	loc file = grabBenchmarkResultsLoc("hsqldb-M3-write-batch");
	writeCSV(results, file);
}

private list[int] lapdWrite(int runs, &T v, int(str, &T) measure) {	
	str id = generateId();
	int total = 0;
	list[int] result = [];
	for (n <- [0..runs]) {
		id = generateId();
		int time = measure(id, v);
		result += time;
		total += time;
	}
	avg = total / runs;
	result += avg;
	return result;
}

private list[int] textWrite(int runs, &T v, int(loc, &T) measure) {
	loc file = grabTextFileLoc();
	int total = 0;
	list[int] result = [];
	for (n <- [0..runs]) {
		int time = measure(file, v);
		result += time;
		total += time;
	}
	avg = total / runs;
	result += avg;
	return result;
}

private list[int] binaryWrite(int runs, &T v, int(loc, &T) measure) {
	loc file = grabBinaryFileLoc();
	int total = 0;
	list[int] result = [];
	for (n <- [0..runs]) {
		int time = measure(file, v);
		result += time;
		total += time;
	}
	avg = total / runs;
	result += avg;
	return result;
}

