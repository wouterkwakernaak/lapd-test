module Benchmark::IntegerBenchmark

import LAPD;
import IO;
import util::Benchmark;

public void runIntegerBenchmarks() {
	str id = generateUniqueId();
	measureWrite(id);
	measureRead(id);
}

private void measureWrite(str id)
{
	begin = realTime();
	write(id, 5);
	used = realTime() - begin;
	println("write integer = <used> milliseconds");
}

private void measureRead(str id)
{
	begin = realTime();
	read(id, #int);
	used = realTime() - begin;
	println("read integer = <used> milliseconds");
}
