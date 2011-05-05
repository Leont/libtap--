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
	cp --preserve=timestamps libtap++.so $(PREFIX)/lib/
	cp -dR --preserve=timestamps,links headers/tap++/ $(PREFIX)/include/
	chmod a+x $(PREFIX)/include/tap++
	chmod -R a+r $(PREFIX)/include/tap++
	chmod a+rx $(PREFIX)/lib/libtap++.so

uninstall:
	-rm $(PREFIX)/lib/libtap++.so
	-rm -r $(PREFIX)/include/tap++

.PHONY: todo install test testbuild clean testclean all uninstall

todo:
	@for i in FIX''ME XX''X TO''DO; do echo -n "$$i: "; $(ACK) $$i | wc -l; done;

apicount: libtap++.so
	@echo -n "Number of entries: "
	@nm libtap++.so -C --defined-only | egrep -i " [TW] TAP::" | wc -l
