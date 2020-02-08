make clean
rm fuzz fuzz.bc fuzz.fast fuzz.o fuzz.tt
LDFLAGS="-L/local_home/cheong/Angora_funb/bin/lib/libcxx_fast -lc++" CXX=gclang++ CXXFLAGS="-v -stdlib=libc++" make

get-bc fuzz

LDFLAGS="-L/local_home/cheong/Angora_funb/bin/lib/libcxx_fast -lc++" CXXFLAGS="-v -stdlib=libc++" /local_home/cheong/Angora_func/bin/angora-clang++ fuzz.bc -o fuzz.fast
LDFLAGS="-L/local_home/cheong/Angora_funb/bin/lib/libcxx_fast -lc++" CXXFLAGS="-v -stdlib=libc++" USE_TRACK=1  /local_home/cheong/Angora_func/bin/angora-clang++ fuzz.bc -o fuzz.tt
