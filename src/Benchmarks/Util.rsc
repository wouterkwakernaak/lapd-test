module Benchmarks::Util

import lang::java::jdt::m3::Core;
import LAPD;
import DateTime;
import ValueIO;

public loc smallAnalysisProjectLoc = |project://smallsql_0.21_src|;

public loc largeAnalysisProjectLoc = |project://hsqldb-2.3.1|;

public loc smallJavaFile = |project://smallsql_0.21_src/src/smallsql/database/Column.java|;

public str smallJavaPrjId = "smallsql";

public str largeJavaPrjId = "hsqldb";

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
	write(largeJavaPrjId, createM3FromEclipseProject(largeAnalysisProjectLoc));
}

public void insertSmallProjectIntoLapd() {
	write(smallJavaPrjId, createM3FromEclipseProject(smallAnalysisProjectLoc));
}

public void insertSmallProjectIntoBinaryFile() {
	writeBinaryValueFile(grabBinaryFileLoc(), createM3FromEclipseProject(smallAnalysisProjectLoc));
}

public void insertLargeProjectIntoBinaryFile() {
	writeBinaryValueFile(grabBinaryFileLoc(), createM3FromEclipseProject(largeAnalysisProjectLoc));
}