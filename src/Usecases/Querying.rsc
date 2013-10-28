module Usecases::Querying

import IO;
import LAPD;
import lang::java::jdt::m3::Core;

private str id = "lapd M3 model";

public void storeAnM3Model() {
	write(id, createM3FromEclipseProject(|project://lapd|));
}

public void queryTheFullModel() {
	M3 model = executeQuery("start n=node:nodes(id = \'" + id + "\') return n", #M3);
	println(model@types);
}

