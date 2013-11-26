module Usecases::ResursiveMethodsQuery

import IO;
import LAPD;
import lang::java::jdt::m3::Core;

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

public void recursiveMethodsHybrid() {
	rel[loc from, loc to] invocations = executeQuery("start n=node:nodes(id = \'smallsql\') match n-[:ANNOTATION]-\>anno where anno.annotation = \'methodInvocation\' return anno", #rel[loc from, loc to], false);
	findRecursiveMethods(invocations);
}

private void findRecursiveMethods(rel[loc from, loc to] invocations) {
	l = for (tuple[loc from, loc to] invocation <- invocations) {
		str methodFrom = invocation.from.path;
		str methodTo = invocation.to.path;	
		if (/<methodTo>/ := methodFrom)
			append invocation.to;
	}
	s = {x | x <- l};
	int i = 0;
	for (x <- s) {
		println(x);
		i = i + 1;
	}
	println(i);
}

public void recursiveMethodsLoadFullValue() {
	M3 m3 = read("smallsql", #M3);
	findRecursiveMethods(m3@methodInvocation);	
}