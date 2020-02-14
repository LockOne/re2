ANGORA_LOC=/local_home/cheong/Angora_func

make clean
rm fuzz fuzz.bc fuzz.fast fuzz.o fuzz.tt
LDFLAGS="-lc++" CXX=gclang++ CXXFLAGS="-v -stdlib=libc++" make

get-bc fuzz

LDFLAGS="-lc++" CXXFLAGS="-v -stdlib=libc++" ${ANGORA_LOC}/bin/angora-clang++ fuzz.bc -o ${ANGORA_LOC}/subjects/re2.fast
mv FuncInfo.txt ${ANGORA_LOC}/FInfos/FuncInfo-re2.txt
LDFLAGS="-lc++" CXXFLAGS="-v -stdlib=libc++" USE_TRACK=1  ${ANGORA_LOC}/bin/angora-clang++ fuzz.bc -o ${ANGORA_LOC}/subjects/re2.tt
