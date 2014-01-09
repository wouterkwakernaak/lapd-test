module Queries::SwitchQuery

import ValueIO;
import LAPD;
import lang::java::m3::AST;

//public set[Statement] switchJavaQuery() {
//	return executeJavaQuery(2, "", #set[Statement]);
//}
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
//private set[Statement] findSwitchesNoDefault(set[Declaration] asts) {
//	switchStmts = for(ast <- asts) {
//		visit(ast) {
//			case \switch(e, list[Statement] stmts): {
//				bool defaultCaseFound = false;
//				for (s <- stmts) {
//					if (s := \defaultCase()) {
//						defaultCaseFound = true;
//						break;
//					}
//				}
//				if (!defaultCaseFound)
//					append \switch(e, stmts);
//			}
//		};
//	}
//	return {s | s <- switchStmts};
//}

public set[Statement] switchCypher() {
	set[Statement] allSwitches = executeQuery("start n=node:nodes(node = \'switch\') return n", #set[Statement], true);
	set[Statement] switchesWithDefault = executeQuery("start n=node:nodes(node = \'switch\') match n-[:HEAD]-\>()-[:TO]-\>()-[:HEAD]-\>()-[:TO*]-\>d where d.node = \'defaultCase\' return n", #set[Statement], true);
	set[Statement] switchesNoDefault = allSwitches - switchesWithDefault;
	return switchesNoDefault;		
}