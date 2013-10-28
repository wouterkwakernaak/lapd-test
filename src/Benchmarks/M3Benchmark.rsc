module Benchmarks::M3Benchmark

import LAPD;
import IO;
import ValueIO;
import List;
import util::Benchmark;
import lang::java::jdt::m3::Core;

public void runM3Benchmarks() {
	str id = generateUniqueId();
	M3 v = createM3FromEclipseProject(|project://lapd|);
	println("retrieved M3 model");
	loc file = getDbDirectoryPath() + "textValueIO.io";
	measureTextWrite(file, v);
	measureTextRead(file);
	file = getDbDirectoryPath() + "binaryValueIO.io";
	measureBinaryWrite(file, v);
	measureBinaryRead(file);
	measureLapdWrite(id, v);
	measureLapdRead(id, v);
}

private void measureLapdWrite(str id, M3 v)
{
	println("writing to lapd...");
	begin = realTime();
	write(id, v);
	used = realTime() - begin;
	println("write m3 model to lapd = <used> milliseconds");
}

private void measureLapdRead(str id, M3 v)
{
	println("reading from lapd...");
	begin = realTime();
	M3 x = read(id, #M3);	
	used = realTime() - begin;
	println("read m3 model from lapd = <used> milliseconds");
	assert v@messages == x@messages;
	assert v@uses == x@uses;
	assert v@containment == x@containment;
	assert v@names == x@names;
	assert v@documentation == x@documentation;
	assert v@modifiers == x@modifiers;
	assert v@types == x@types;
	assert v@declarations == x@declarations;	
}

private void measureTextWrite(loc file, M3 v) {
	println("writing to textfile...");
	begin = realTime();
	writeTextValueFile(file, v);
	used = realTime() - begin;
	println("write m3 model to textfile = <used> milliseconds");
}

private void measureTextRead(loc file) {
	println("reading from text file...");
	begin = realTime();
	M3 x = readTextValueFile(#M3, file);
	used = realTime() - begin;
	println("read m3 model from textfile = <used> milliseconds");
}

private void measureBinaryWrite(loc file, M3 v) {
	println("writing to binary file...");
	begin = realTime();
	writeBinaryValueFile(file, v);
	used = realTime() - begin;
	println("write m3 model to binary file = <used> milliseconds");
}

private void measureBinaryRead(loc file) {
	println("reading from binary file...");
	begin = realTime();
	M3 x = readBinaryValueFile(#M3, file);
	used = realTime() - begin;
	println("read m3 model from binary file = <used> milliseconds");
}
