
all: release

# Additional warning flags, safe math, without optimization:
debug: main.jl src/cm_functions.jl
	julia --depwarn=yes --procs auto --math-mode=ieee --color=yes --optimize=0 main.jl

# Maximum optimization, increase lib precompilation, unsafe math:
release: main.jl src/cm_functions.jl
	julia --optimize=3 --sysimage-native-code=yes --compiled-modules=yes --procs auto --math-mode=fast --color=yes main.jl

# Without optimization:
test: main.jl src/cm_functions.jl
	julia --procs auto --optimize=0 --color=yes  main.jl
