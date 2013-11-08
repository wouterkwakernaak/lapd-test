module Benchmarks::ASTBenchmark

import LAPD;
import IO;
import ValueIO;
import Benchmarks::Util;
import util::Benchmark;
import lang::java::m3::AST;

public void runAndPrintAnASTBenchmark() {
	str id = generateId();
	Declaration ast = createSmallAST();
	println("write ast to lapd = <measureLapdASTWrite(id, ast)> milliseconds");	
	println("read ast from lapd = <measureLapdASTRead(id)> milliseconds");
	loc file = grabTextFileLoc();
	println("write ast to textfile = <measureTextASTWrite(file, ast)> milliseconds");	
	println("read ast from textfile = <measureTextASTRead(file)> milliseconds");
	file = grabBinaryFileLoc();	
	println("write ast to binary file = <measureBinaryASTWrite(file, ast)> milliseconds");	
	println("read ast from binary file = <measureBinaryASTRead(file)> milliseconds");	
	
}

public Declaration createSmallAST() {
	return createAstFromFile(smallJavaFile, true);
}

public int measureLapdASTWrite(str id, Declaration v)
{
	begin = realTime();
	write(id, v);
	used = realTime() - begin;
	return used;
}

public int measureLapdASTRead(str id)
{
	begin = realTime();
	Declaration x = read(id, #Declaration);	
	used = realTime() - begin;
	return used;
}

public int measureTextASTWrite(loc file, Declaration v) {
	begin = realTime();
	writeTextValueFile(file, v);
	used = realTime() - begin;
	return used;
}

public int measureTextASTRead(loc file) {
	begin = realTime();
	Declaration x = readTextValueFile(#Declaration, file);
	used = realTime() - begin;
	return used;
}

public int measureBinaryASTWrite(loc file, Declaration v) {
	begin = realTime();
	writeBinaryValueFile(file, v);
	used = realTime() - begin;
	return used;
}

public int measureBinaryASTRead(loc file) {
	begin = realTime();
	Declaration x = readBinaryValueFile(#Declaration, file);
	used = realTime() - begin;
	return used;
}
