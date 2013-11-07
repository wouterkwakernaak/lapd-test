module Benchmarks::SequentialWrite

import Benchmarks::IntegerBenchmark;
import Benchmarks::M3Benchmark;
import Benchmarks::Util;
import lang::csv::IO;
import lang::java::jdt::m3::Core;

public void benchSequentialIntWrite() {
	int runs = 100;
	int intValue = 5;
	loc file = grabBenchmarkResultsLoc("integer-sequential-write");
	rel[str store, int time] results = {<"lapd", lapdWrite(runs, intValue, measureLapdIntWrite)>, 
	<"text file", textWrite(runs, intValue, measureTextIntWrite)>, 
	<"binary file", binaryWrite(runs, intValue, measureBinaryIntWrite)>};
	writeCSV(results, file);
}

public void benchSequentialSmallM3Write() {
	int runs = 10;
	M3 m3 = createSmallM3();
	loc file = grabBenchmarkResultsLoc("M3-sequential-write");
	rel[str store, int time] results = {<"lapd", lapdWrite(runs, m3, measureLapdM3Write)>, 
	<"text file", textWrite(runs, m3, measureTextM3Write)>, 
	<"binary file", binaryWrite(runs, m3, measureBinaryM3Write)>};
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
