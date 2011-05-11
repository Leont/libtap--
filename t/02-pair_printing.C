#include <tap++/tap++.h>
#include <string>
#include <sstream>

int main(){
	using namespace TAP;
	using namespace std;

	plan(4);

	{
		pair<int, string> p=make_pair(12,"foo");
		ostringstream out;
		bool success = out << p;
		is(success, true, "Successfully print int string pair");
		is(out.str(),"std::pair( 12 , foo )",
		   "Correct output from printing int string pair");
	}

	{
		pair<const char*, double> p=make_pair("Rufus",1.2e107);
		ostringstream out;
		bool success = out << p;
		is(success, true, "Successfully print char* double pair");
		is(out.str(),"std::pair( Rufus , 1.2e+107 )",
		   "Correct output from printing char* double pair");
	}

	return exit_status();
}

