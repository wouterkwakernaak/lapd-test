module Benchmarks::Util

import lang::java::jdt::m3::Core;
import LAPD;
import DateTime;

public loc smallAnalysisProjectLoc = |project://smallsql_0.21_src|;

public loc largeAnalysisProjectLoc = |project://hsqldb-2.3.1|;

public loc smallJavaFile = |project://smallsql_0.21_src/src/smallsql/database/Column.java|;

public loc grabTextFileLoc() {
	return getDbDirectoryPath() + "textValueIO.io";
}

public loc grabBinaryFileLoc() {
	return getDbDirectoryPath() + "binaryValueIO.io";
}

public loc grabBenchmarkResultsLoc(str fileName) {
	return |home:///benchmarks| + (fileName + "_" + printDateTime(now(), "dd-MM-YY_HH:mm:ss") + ".csv");
}

public str generateId() {
	return generateUniqueId();
}

public void insertLargeProjectIntoLapd() {
	write("hsqldb", createM3FromEclipseProject(largeAnalysisProjectLoc));
}

public void insertSmallProjectIntoLapd() {
	write("smallsql", createM3FromEclipseProject(smallAnalysisProjectLoc));
}