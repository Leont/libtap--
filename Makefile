CXX = g++
ACK = ack
LIB = libtap++.so
WARNINGS = -Wall -Wextra -Weffc++
DEBUG = -ggdb3 -DDEBUG
CXXFLAGS = $(DEBUG) $(WARNINGS) -fPIC
PREFIX=/usr/local
LIBRARY_VAR=LD_LIBRARY_PATH
TEST_GOALS = t/00-sanity.t

all: $(LIB)

$(LIB): source/tap++.C headers/tap++/tap++.h
	$(CXX) -shared -o $@ -Wl,-soname,$(LIB) $(CXXFLAGS) -lboost_regex -Iheaders source/*.C

t/%.t: t/%.C $(LIB)
	$(CXX) $(CXXFLAGS) -L. -ltap++ -Iheaders -o $@ $< 

testbuild: $(TEST_GOALS)

test: $(TEST_GOALS)
	@echo run_tests.pl $(TEST_GOALS)
	@$(LIBRARY_VAR)=. ./run_tests.pl $(TEST_GOALS)

clean:
	-rm -r $(LIB) $(wildcard t/*.t) 2>/dev/null

testclean:
	-rm t/*.t 2>/dev/null

again: clean all

love:
	@echo Not war?

install: $(LIB)
	cp libtap++.so $(PREFIX)/lib/
	cp -a headers/tap++/ $(PREFIX)/include/

.PHONY: todo install test testbuild clean testclean all

todo:
	@for i in FIX''ME XX''X TO''DO; do echo -n "$$i: "; $(ACK) $$i | wc -l; done;

apicount: libtap++.so
	@echo -n "Number of entries: "
	@nm libtap++.so -C --defined-only | egrep -i " [TW] TAP::" | wc -l
