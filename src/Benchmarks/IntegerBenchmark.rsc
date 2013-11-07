module Benchmarks::IntegerBenchmark

import LAPD;
import IO;
import ValueIO;
import Benchmarks::Util;
import util::Benchmark;

public void runAndPrintAnIntegerBenchmark() {
	str id = generateId();
	println("write integer to lapd = <measureLapdIntWrite(id)> milliseconds");
	println("read integer from lapd = <measureLapdIntRead(id)> milliseconds");
	loc file = grabTextFileLoc();
	println("write integer to textfile = <measureTextIntWrite(file)> milliseconds");
	println("read integer from textfile = <measureTextIntRead(file)> milliseconds");
	file = grabBinaryFileLoc();	
	println("write integer to binary file = <measureBinaryIntWrite(file)> milliseconds");	
	println("read integer from binary file = <measureBinaryIntRead(file)> milliseconds");
}

public int measureLapdIntWrite(str id)
{
	begin = realTime();
	write(id, 5);
	used = realTime() - begin;
	return used;
}

public int measureLapdIntRead(str id)
{
	begin = realTime();
	int x = read(id, #int);
	used = realTime() - begin;
	return used;
}

public int measureTextIntWrite(loc file) {
	begin = realTime();
	writeTextValueFile(file, 5);
	used = realTime() - begin;
	return used;
}

public int measureTextIntRead(loc file) {
	begin = realTime();
	int x = readTextValueFile(#int, file);
	used = realTime() - begin;
	return used;
}

public int measureBinaryIntWrite(loc file) {
	begin = realTime();
	writeBinaryValueFile(file, 5);
	used = realTime() - begin;
	return used;
}

public int measureBinaryIntRead(loc file) {
	begin = realTime();
	int x = readBinaryValueFile(#int, file);
	used = realTime() - begin;
	return used;
}
