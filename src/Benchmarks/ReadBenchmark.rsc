module Benchmarks::ReadBenchmark

import Benchmarks::IntegerBenchmark;
import Benchmarks::M3Benchmark;
import Benchmarks::ASTBenchmark;
import Benchmarks::Util;
import lang::csv::IO;
import lang::java::m3::Core;
import lang::java::m3::AST;
import IO;

public void benchIntRead() {
	int runs = 5;
	int intValue = 5;	
	rel[str store, list[int] time] results = {<"lapd", lapdRead(runs, intValue, measureLapdIntWrite, measureLapdIntRead)>, 
	<"text file", textRead(runs, intValue, measureTextIntWrite, measureTextIntRead)>, 
	<"binary file", binaryRead(runs, intValue, measureBinaryIntWrite, measureBinaryIntRead)>};
	loc file = grabBenchmarkResultsLoc("integer-read");
	writeCSV(results, file);
}

public void benchASTRead() {
	int runs = 5;
	Declaration ast = createSmallAST();	
	rel[str store, list[int] time] results = {<"lapd", lapdRead(runs, ast, measureLapdASTWrite, measureLapdASTRead)>, 
	<"text file", []>, 
	<"binary file", binaryRead(runs, ast, measureBinaryASTWrite, measureBinaryASTRead)>};
	loc file = grabBenchmarkResultsLoc("AST-read");
	writeCSV(results, file);
}

public void benchM3Read() {
	int runs = 5;
	M3 m3 = createSmallM3();	
	rel[str store, list[int] time] results = {<"lapd", lapdRead(runs, m3, measureLapdM3Write, measureLapdM3Read)>, 
	<"text file", textRead(runs, m3, measureTextM3Write, measureTextM3Read)>, 
	<"binary file", binaryRead(runs, m3, measureBinaryM3Write, measureBinaryM3Read)>};
	loc file = grabBenchmarkResultsLoc("smallsql-M3-read");
	writeCSV(results, file);
}

private list[int] lapdRead(int runs, &T v, int(str, &T) writeFunc, int(str) readFunc) {	
	str id = generateId();
	writeFunc(id, v);
	int total = 0;
	list[int] result = [];
	for (n <- [0..runs]) {
		int time = readFunc(id);
		result += time;
		total += time;
	}
	avg = total / runs;
	result += avg;
	return result;
}

private list[int] textRead(int runs, &T v, int(loc, &T) writeFunc, int(loc) readFunc) {
	loc file = grabTextFileLoc();
	writeFunc(file, v);
	int total = 0;
	list[int] result = [];	
	for (n <- [0..runs]) {
		int time = readFunc(file);
		result += time;
		total += time;
	}
	avg = total / runs;
	result += avg;
	return result;
}

private list[int] binaryRead(int runs, &T v, int(loc, &T) writeFunc, int(loc) readFunc) {
	loc file = grabBinaryFileLoc();
	writeFunc(file, v);
	int total = 0;	
	list[int] result = [];
	for (n <- [0..runs]) {
		int time = readFunc(file);
		result += time;
		total += time;
	}
	avg = total / runs;
	result += avg;
	return result;
}