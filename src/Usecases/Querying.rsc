module Usecases::Querying

import IO;
import LAPD;
import lang::java::jdt::m3::Core;
import lang::java::jdt::m3::AST;
import lang::java::jdt::Java;
import lang::java::jdt::JDT;
import lang::java::jdt::JavaADT;

private str m3Id = "lapd M3 model";
private str ASTsId = "lapd ASTs";
private str OldJDTId = "old jdt id";
private loc prjLoc = |project://lapd|;

public void storeAnM3Model() {
	write(m3Id, createM3FromEclipseProject(prjLoc));
}

// doesn't seem to store anything
public void storeASTs() {
	write(ASTsId, createAstsFromDirectory(prjLoc, true));
}

public void queryFullM3Model() {
	M3 model = executeQuery("start n=node:nodes(id = \'" + m3Id + "\') return n", #M3);
	println(model@methodInvocation);
}

public void queryASTs() {
	set[Declaration] asts = executeQuery("start n=node:nodes(id = \'" + ASTsId + "\') return n", #set[Declaration]);
	for (n <- asts)
		println(n);
}

// doesn't work :(
public void storeProject() {
	write(OldJDTId, extractProject(prjLoc));
}

public void printMethods() {
	Resource prj = read(OldJDTId, #Resource);
	println({method | <_, method> <- prj@methodBodies});
}

