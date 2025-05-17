# Makefile to build example for native CEX replay

# If building with non-hclang++ compiler, will need to specify
# location of include-files.  hclang++ has the include-file directory
# paths compiled-in.
#

#CXXFLAGS = -I$(HECTOR_HOME)/local -I$(HECTOR_HOME)/local/include

CXX = $(HECTOR_HOME)/frontend/$(TARGET_ARCH)/bin/hclang++
DBG = -g
ARCH = -m32

SPEC_OBJS = test.o
SPEC_INCL = -I./blitz-0.10
BLITZ_WARN = -Wno-parentheses -Wno-header-guard

%.o : %.cc
	$(CXX) -c $(DBG) $(ARCH) $(CXXFLAGS) $(SPEC_INCL) $(BLITZ_WARN) $<

# To build for Counter-example replay, must compile and link using
# hclang++; it automatically adds all the required options for a
# successful compile and link; this includes extra includes, files,
# libraries and command-line options.
#
# hclang++ generates LLVM BitCode alongside the native code in the
# object file / executable.  This allows you to use 'cppan -import' to
# load an executable built by a Makefile such as this into Hector for
# formal model generation without having to recompile / relink it

spec.exe: $(SPEC_OBJS)
	$(CXX) $^ $(DBG) $(ARCH) -o $@

spec: spec.exe

all: spec

clean:
	rm -f *.o *.bc spec.exe *.log spec.includes
