module Benchmarks::SequentialRead

import Benchmarks::IntegerBenchmark;
import Benchmarks::M3Benchmark;
import Benchmarks::ASTBenchmark;
import Benchmarks::Util;
import lang::csv::IO;
import lang::java::m3::Core;
import lang::java::m3::AST;
import IO;

public void benchSequentialIntRead() {
	int runs = 50;
	int intValue = 5;	
	rel[str store, int time] results = {<"lapd", lapdRead(runs, intValue, measureLapdIntWrite, measureLapdIntRead)>, 
	<"text file", textRead(runs, intValue, measureTextIntWrite, measureTextIntRead)>, 
	<"binary file", binaryRead(runs, intValue, measureBinaryIntWrite, measureBinaryIntRead)>};
	loc file = grabBenchmarkResultsLoc("integer-sequential-read");
	writeCSV(results, file);
}

public void benchSequentialASTRead() {
	int runs = 50;
	Declaration ast = createSmallAST();	
	rel[str store, int time] results = {<"lapd", lapdRead(runs, ast, measureLapdASTWrite, measureLapdASTRead)>, 
	<"text file", 0>, 
	<"binary file", binaryRead(runs, ast, measureBinaryASTWrite, measureBinaryASTRead)>};
	loc file = grabBenchmarkResultsLoc("AST-sequential-read");
	writeCSV(results, file);
}

public void benchSequentialSmallM3Read() {
	int runs = 5;
	M3 m3 = createSmallM3();	
	rel[str store, int time] results = {<"lapd", lapdRead(runs, m3, measureLapdM3Write, measureLapdM3Read)>, 
	<"text file", textRead(runs, m3, measureTextM3Write, measureTextM3Read)>, 
	<"binary file", binaryRead(runs, m3, measureBinaryM3Write, measureBinaryM3Read)>};
	loc file = grabBenchmarkResultsLoc("M3-sequential-read");
	writeCSV(results, file);
}

private int lapdRead(int runs, &T v, int(str, &T) writeFunc, int(str) readFunc) {	
	//str id = generateId();
	//writeFunc(id, v);
	str id = "hsqldb";
	int total = 0;	
	for (n <- [0..runs]) {
		total += readFunc(id);
	}
	avg = total / runs;
	return avg;
}

private int textRead(int runs, &T v, int(loc, &T) writeFunc, int(loc) readFunc) {
	loc file = grabTextFileLoc();
	writeFunc(file, v);
	int total = 0;	
	for (n <- [0..runs]) {
		total += readFunc(file);
	}
	avg = total / runs;
	return avg;
}

private int binaryRead(int runs, &T v, int(loc, &T) writeFunc, int(loc) readFunc) {
	loc file = grabBinaryFileLoc();
	writeFunc(file, v);
	int total = 0;	
	for (n <- [0..runs]) {
		total += readFunc(file);
	}
	avg = total / runs;
	return avg;
}