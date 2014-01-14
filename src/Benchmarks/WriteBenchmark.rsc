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
	int runs = 50;
	int intValue = 7;	
	rel[str store, int time] results = {<"lapd", lapdWrite(runs, intValue, measureLapdIntWrite)>, 
	<"text file", textWrite(runs, intValue, measureTextIntWrite)>, 
	<"binary file", binaryWrite(runs, intValue, measureBinaryIntWrite)>};
	loc file = grabBenchmarkResultsLoc("integer-write");
	writeCSV(results, file);
}

public void benchASTWrite() {
	int runs = 50;
	Declaration ast = createSmallAST();	
	rel[str store, int time] results = {<"lapd", lapdWrite(runs, ast, measureLapdASTWrite)>, 
	<"text file", textWrite(runs, ast, measureTextASTWrite)>, 
	<"binary file", binaryWrite(runs, ast, measureBinaryASTWrite)>};
	loc file = grabBenchmarkResultsLoc("AST-write");
	writeCSV(results, file);
}

public void benchSmallM3Write() {
	int runs = 5;
	M3 m3 = createSmallM3();	
	rel[str store, int time] results = {<"lapd", lapdWrite(runs, m3, measureLapdM3Write)>, 
	<"text file", textWrite(runs, m3, measureTextM3Write)>, 
	<"binary file", binaryWrite(runs, m3, measureBinaryM3Write)>};
	loc file = grabBenchmarkResultsLoc("M3-write");
	writeCSV(results, file);
}

private int lapdWrite(int runs, &T v, int(str, &T) measure) {	
	str id = generateId();
	measureLapdIntWrite(id, 123); // make sure the DB engine is running
	int total = 0;	
	for (n <- [0..runs]) {
		id = generateId();
		total += measure(id, v);
	}
	avg = total / runs;
	return avg;
}

private int textWrite(int runs, &T v, int(loc, &T) measure) {
	loc file = grabTextFileLoc();
	int total = 0;	
	for (n <- [0..runs]) {
		total += measure(file, v);
	}
	avg = total / runs;
	return avg;
}

private int binaryWrite(int runs, &T v, int(loc, &T) measure) {
	loc file = grabBinaryFileLoc();
	int total = 0;	
	for (n <- [0..runs]) {
		total += measure(file, v);
	}
	avg = total / runs;
	return avg;
}

