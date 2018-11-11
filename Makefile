NON_OPTIMIZATION_FLAGS := --depwarn=yes --procs auto --math-mode=ieee --color=yes --optimize=0
OPTIMIZATION_FLAGS := --optimize=3 --sysimage-native-code=yes --compiled-modules=yes --procs auto --math-mode=fast --color=yes

SOURCES := main.jl src/cm_functions.jl

all: release

# Additional warning flags, safe math, without optimization:
debug: $(SOURCES)
	julia $(NON_OPTIMIZATION_FLAGS) main.jl

# Maximum optimization, increase lib precompilation, unsafe math:
release: $(SOURCES)
	julia $(OPTIMIZATION_FLAGS) main.jl

# Speed tests with different optimization flags:
speed_test: $(SOURCE) ./test/speed.jl
	echo "Without optimization(Debug):"
	julia $(NON_OPTIMIZATION_FLAGS) ./test/speed.jl
	echo "With optimization(Release):"
	julia $(OPTIMIZATION_FLAGS) ./test/speed.jl

# Installation of julia dependencies:
deps_install: ./deps/install.jl
	julia ./deps/install.jl
