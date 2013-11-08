module Benchmarks::Benchmarks

import Benchmarks::IntegerBenchmark;
import Benchmarks::M3Benchmark;
import Benchmarks::ASTBenchmark;

public void main() {
	runAndPrintAnIntegerBenchmark();	
	runAndPrintAnASTBenchmark();
	runAndPrintAnM3Benchmark();
}