module Benchmarks::M3Benchmark

import LAPD;
import IO;
import ValueIO;
import Benchmarks::Util;
import util::Benchmark;
import lang::java::jdt::m3::Core;

public void runAndPrintAnM3Benchmark() {
	str id = generateId();
	M3 m3 = createSmallM3();
	println("write m3 model to lapd = <measureLapdM3Write(id, m3)> milliseconds");	
	println("read m3 model from lapd = <measureLapdM3Read(id)> milliseconds");
	loc file = grabTextFileLoc();
	println("write m3 model to textfile = <measureTextM3Write(file, m3)> milliseconds");	
	println("read m3 model from textfile = <measureTextM3Read(file)> milliseconds");
	file = grabBinaryFileLoc();	
	println("write m3 model to binary file = <measureBinaryM3Write(file, m3)> milliseconds");	
	println("read m3 model from binary file = <measureBinaryM3Read(file)> milliseconds");	
	
}

public M3 createSmallM3() {
	return createM3FromEclipseProject(smallAnalysisProjectLoc);
}

public int measureLapdM3Write(str id, M3 v)
{
	begin = realTime();
	write(id, v);
	used = realTime() - begin;
	return used;
}

public int measureLapdM3Read(str id)
{
	begin = realTime();
	M3 x = read(id, #M3);	
	used = realTime() - begin;
	return used;
}

public int measureTextM3Write(loc file, M3 v) {
	begin = realTime();
	writeTextValueFile(file, v);
	used = realTime() - begin;
	return used;
}

public int measureTextM3Read(loc file) {
	begin = realTime();
	M3 x = readTextValueFile(#M3, file);
	used = realTime() - begin;
	return used;
}

public int measureBinaryM3Write(loc file, M3 v) {
	begin = realTime();
	writeBinaryValueFile(file, v);
	used = realTime() - begin;
	return used;
}

public int measureBinaryM3Read(loc file) {
	begin = realTime();
	M3 x = readBinaryValueFile(#M3, file);
	used = realTime() - begin;
	return used;
}
