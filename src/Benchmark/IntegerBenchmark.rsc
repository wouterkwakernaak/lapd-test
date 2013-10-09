module Benchmark::IntegerBenchmark

import LAPD;
import IO;
import ValueIO;
import util::Benchmark;

public void runIntegerBenchmarks() {
	str id = generateUniqueId();
	measureLapdWrite(id);
	measureLapdRead(id);
	loc file = |file:///ufs/wouterk/databases/textValueIO.io|;
	measureTextWrite(file);
	measureTextRead(file);
	file = |file:///ufs/wouterk/databases/binaryValueIO.io|;
	measureBinaryWrite(file);
	measureBinaryRead(file);
}

private void measureLapdWrite(str id)
{
	begin = realTime();
	write(id, 5);
	used = realTime() - begin;
	println("write integer to lapd = <used> milliseconds");
}

private void measureLapdRead(str id)
{
	begin = realTime();
	int x = read(id, #int);
	used = realTime() - begin;
	println("read integer from lapd = <used> milliseconds");
}

private void measureTextWrite(loc file) {
	begin = realTime();
	writeTextValueFile(file, 5);
	used = realTime() - begin;
	println("write integer to textfile = <used> milliseconds");
}

private void measureTextRead(loc file) {
	begin = realTime();
	int x = readTextValueFile(#int, file);
	used = realTime() - begin;
	println("read integer from textfile = <used> milliseconds");
}

private void measureBinaryWrite(loc file) {
	begin = realTime();
	writeBinaryValueFile(file, 5);
	used = realTime() - begin;
	println("write integer to binary file = <used> milliseconds");
}

private void measureBinaryRead(loc file) {
	begin = realTime();
	int x = readBinaryValueFile(#int, file);
	used = realTime() - begin;
	println("read integer from binary file = <used> milliseconds");
}
