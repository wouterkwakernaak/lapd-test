module Benchmarks::SequentialWrite

import Benchmarks::IntegerBenchmark;
import Benchmarks::Util;
import lang::csv::IO;

public void benchSequentialWrite() {
	int runs = 100;
	loc file = grabBenchmarkResultsLoc("integer-sequential-write");
	rel[str storageType, int time] results = {<"lapd", lapdWrite(runs)>, 
	<"text file", textWrite(runs)>, <"binary file", binaryWrite(runs)>};
	writeCSV(results, file);
}

private int lapdWrite(int runs) {	
	str id = generateId();
	measureLapdIntWrite(id); // make sure the DB engine is running
	int total = 0;	
	for (n <- [0..runs]) {
		id = generateId();
		total += measureLapdIntWrite(id);
	}
	avg = total / runs;
	return avg;
}

private int textWrite(int runs) {
	loc file = grabTextFileLoc();
	int total = 0;	
	for (n <- [0..runs]) {
		total += measureTextIntWrite(file);
	}
	avg = total / runs;
	return avg;
}

private int binaryWrite(int runs) {
	loc file = grabBinaryFileLoc();
	int total = 0;	
	for (n <- [0..runs]) {
		total += measureBinaryIntWrite(file);
	}
	avg = total / runs;
	return avg;
}

