module Usecases::Querying

import IO;
import LAPD;
import lang::java::jdt::m3::Core;
import lang::java::jdt::m3::AST;

private str m3Id = "lapd M3 modelx";
private str ASTsId = "lapd ASTs";
private loc prjLoc = |project://lapd|;

public void storeAnM3Model() {
	write(m3Id, createM3FromEclipseProject(prjLoc));
}

// appears to be bugged
public void storeASTs() {
	M3 model = queryFullM3Model();
	for (method <- methods(model)) {
		println(method);
		println(getMethodAST(method, model=model));
	}
	//set[Declaration] asts = createAstsFromDirectory(prjLoc, true);
	//println(asts);
	//for (n <- asts)
	//	println(n);
	//write(ASTsId, asts);
}

public M3 queryFullM3Model() {
	M3 model = executeQuery("start n=node:nodes(id = \'" + m3Id + "\') return n", #M3);
	return model;
}

public void queryM3ForDeclarations() {
	value v = executeQuery("start n=node:nodes(id = \'" + m3Id + "\') match n-[:ANNOTATION]-\>anno where anno.annotation = \'declarations\' return anno");
	println(v);
}

public void queryM3ForMethods() {
	value v = executeQuery("start n=node:nodes(id = \'" + m3Id + "\') match n-[:ANNOTATION]-\>anno-[:HEAD]-\>decl-[:NEXT_ELEMENT]-\>x where anno.annotation = \'declarations\' return x");
	println(v);
}

public void queryASTs() {
	set[Declaration] asts = executeQuery("start n=node:nodes(id = \'" + ASTsId + "\') return n", #set[Declaration]);
	for (n <- asts)
		println(n);
}

