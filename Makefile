
all: build


build: main.jl src/libconv_diff_eq.jl
	julia --optimize=3 --sysimage-native-code=yes --compiled-modules=yes --depwarn=yes -p 8 main.jl
