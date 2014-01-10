module Queries::SwitchQuery

import ValueIO;
import LAPD;
import lang::java::m3::AST;
import IO;

public set[Statement] switchJavaQuery() {
	return executeJavaQuery(2, "", #set[Statement]);
}
//
//public set[Statement] switchLoadFullValue(str id) {
//	set[Declaration] asts = read(id, #set[Declaration]);
//	return findNoDefaultSwitch(asts);	
//}
//
//public set[Statement] switchLoadFullValue(loc file) {
//	set[Declaration] asts = readBinaryValueFile(#set[Declaration], file);
//	return findNoDefaultSwitch(asts);
//}
//
private set[Statement] switchRascal(set[Declaration] asts) {
	switchStmts = for(ast <- asts) {
		visit(ast) {
			case \switch(e, list[Statement] stmts): {
				bool defaultCaseFound = false;
				for (s <- stmts) {
					if (s := \defaultCase()) {
						defaultCaseFound = true;
						break;
					}
				}
				if (!defaultCaseFound)
					append \switch(e, stmts);
			}
		};
	}
	return {s | s <- switchStmts};
}

public void compareSwitches() {
	set[Declaration] asts = executeQuery("start n = node:nodes(id = \'smallsql\') return n", #set[Declaration], false);
	a = switchCypher();
	b = switchJavaQuery();
	c = switchRascal(asts);
	println(a - b);
	println(b - a);
	println(a - c);
	println(c - a);
}

public set[Statement] switchCypher() {
	set[Statement] allSwitches = executeQuery("start n=node:nodes(node = \'switch\') return n", #set[Statement], true);
	set[Statement] switchesWithDefault = executeQuery("start n=node:nodes(node = \'switch\') match n-[:HEAD]-\>()-[:TO]-\>()-[:HEAD]-\>()-[:TO*]-\>d where d.node = \'defaultCase\' return n", #set[Statement], true);
	set[Statement] switchesNoDefault = allSwitches - switchesWithDefault;
	return switchesNoDefault;		
}