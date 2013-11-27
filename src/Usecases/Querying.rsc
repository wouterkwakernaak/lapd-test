module Usecases::Querying
// Module containing experimental querying code

import IO;
import LAPD;
import lang::java::jdt::m3::Core;
import lang::java::m3::AST;

private str m3Id = "lapd M3 modelyo";
private str ASTsId = "lapd ASTs";
private loc prjLoc = |project://lapd|;

public void storeTestPrj() {
	write("javatest2", createM3FromEclipseProject(|project://javatest|));
}

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
	M3 model = executeQuery("start n=node:nodes(id = \'" + m3Id + "\') return n", #M3, false);
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

public void queryRecursiveMethodsExpensive() {
	list[loc] v = executeQuery("start n=node:nodes(id = \'javatest2\') match n-[:ANNOTATION]-\>anno-[:HEAD]-\>()-[:NEXT_ELEMENT*0..]-\>()-[:HEAD]-\>from-[:NEXT_ELEMENT]-\>to where anno.annotation = \'methodInvocation\' and from.loc = to.loc return from", #list[loc], true);
	for (x <- v) {
		println(x);
	}
}

public void queryMethodInvocationsAsList() {
	list[tuple[loc from, loc to]] v = executeQuery("start n=node:nodes(id = \'smallsql\') match p=n-[:ANNOTATION]-\>anno-[:HEAD]-\>()-[:NEXT_ELEMENT*0..5]-\>x where anno.annotation = \'methodInvocation\' return x", #list[tuple[loc from, loc to]], true);
	for (x <- v) {
		println(x);
	}
}

public void queryMethodInvocations() {
	rel[loc from, loc to] v = executeQuery("start n=node:nodes(id = \'javatest2\') match n-[:ANNOTATION]-\>anno where anno.annotation = \'methodInvocation\' return anno", #rel[loc from, loc to], false);
	for (x <- v) {
		println(x);
	}
}

