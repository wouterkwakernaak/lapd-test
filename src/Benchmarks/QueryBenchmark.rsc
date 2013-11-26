module Benchmarks::QueryBenchmark

import Usecases::ResursiveMethodsQuery;
import util::Benchmark;

public int measureQuery(str id)
{
	begin = realTime();
	set[value] result = recursiveMethodsJavaQuery(id);	
	used = realTime() - begin;
	return used;
}