module Queries::ResursiveMethodsQuery

import ValueIO;
import IO;
import LAPD;
import lang::java::jdt::m3::Core;
import Queries::Util;

public set[loc] recursiveMethodsJava() {
	return executeJavaQuery(1, "", #set[loc]);
}

public set[loc] recursiveMethodsRascal(rel[loc from, loc to] invocations) {
	return {invocation.from | tuple[loc from, loc to] invocation <- invocations, invocation.from == invocation.to};
}

public set[loc] recursiveMethodsCypher() {
	return executeQuery("start x=node(*) match x-[:TO]-\>x return x", #set[loc], true);
}