module Benchmarks::Util

import LAPD;
import DateTime;

public loc smallAnalysisProjectLoc = |project://smallsql_0.21_src|;

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