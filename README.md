## How to run these tests

1. Setup a rascal development environment, see https://github.com/cwi-swat/rascal/wiki/Rascal-Developers-Setup---Step-by-Step. Clone the rascal fork found at https://github.com/wouterkwakernaak/rascal instead of the main version.
2. Clone lapd and lapd-test
3. Import all projects into Eclipse
4. Change the Circular Dependencies setting to 'Warning' instead of 'Error'. This setting can be found in Eclipse by navigating to Window -> Preferences -> Java -> Compiler -> Building -> Build path problems.
5. Run rascal-eclipse as an Eclipse Application
6. Import lapd-test in the second level Eclipse
7. Run the tests by importing a module of your choice and typing :test in the console or run the benchmarks by importing the Benchmarks module.
