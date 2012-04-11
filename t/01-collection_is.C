#include <tap++/tap++.h>
#include <vector>
#include <string>

int main(){
	using namespace TAP;
	plan(23);
	//First, test the collection_is function
	int col1[3] = {1,2,3};
	int col2[3] = {1,2,3};
	int col3[3] = {1,2,4};

	collection_is(col1,col1,col2,col2,"Two empty collections are identical");

	collection_is(col1,col1+1,col2,col2+1,"Two equal 1 element collections");

	collection_is(col1,col1+3,col2,col2+3,"Two equal 3 element collections");

	TODO="Failing test to test the test harness";
	bool lastResult = collection_is(col1,col1,col2,col2+1,"Should be todo");
	TODO="";
	not_ok(lastResult,"Got zero length, expected length 1");

	TODO="Failing test to test the test harness";
	lastResult = collection_is(col1,col1+1,col2,col2,"Should be todo");
	TODO="";
	not_ok(lastResult,"Got length 1, expected length 0");

	TODO="Failing test to test the test harness";
	lastResult = collection_is(col1,col1+1,col2,col2+3,"Should be todo");
	TODO="";
	not_ok(lastResult,"Got length 1, expected length 3");

	TODO="Failing test to test the test harness";
	lastResult = collection_is(col1,col1+3,col2,col2+1,"Should be todo");
	TODO="";
	not_ok(lastResult,"Got length 3, expected length 1");

	TODO="Failing test to test the test harness";
	lastResult = collection_is(col1,col1+2,col2+1,col2+3,"Should be todo");
	TODO="";
	not_ok(lastResult,"Expected 1 got 2 at index 0");

	TODO="Failing test to test the test harness";
	lastResult = collection_is(col1,col1+3,col3,col3+3,"Should be todo");
	TODO="";
	not_ok(lastResult,"Expected 4 got 3 at index 2");

	char const* col4[1]={"Morning"};
	char const* col5[3]={"Morning","Afternoon","Evening"};
	std::vector<std::string> v4(col4,col4+1), v5(col5,col5+3);
	
	TODO="Failing test to test the test harness";
	lastResult = collection_is(v4.begin(),v4.end(),
				   v5.begin(),v5.end(),"Should be todo");
	TODO="";
	not_ok(lastResult,"String vector got length 1, expected length 3");

	TODO="Failing test to test the test harness";
	lastResult = collection_is(v4.begin(),v4.end(),
				   v5.begin(),v5.begin(),"Should be todo");
	TODO="";
	not_ok(lastResult,"String vector got length 1, expected length 0");

	collection_is(v4.begin(),v4.end(),v5.begin(),v5.begin()+1,
		      "Identical string vectors");

	collection_is(v4.begin(),v4.begin(),v5.begin(),v5.begin(),
		      "Identical empty string vectors");

	TODO="Failing test to test the test harness";
	lastResult = collection_is(v4.begin(),v4.end(),
				   v5.begin()+1,v5.begin()+2,"Should be todo");
	TODO="";
	not_ok(lastResult,"String vectors same length, different contents");

	return exit_status();
}
