ANGORA_LOC=/local_home/cheong/Angora_func

make clean
rm fuzz fuzz.bc fuzz.fast fuzz.o fuzz.tt
CXX=gclang++ CXXFLAGS="-stdlib=libc++" LDFLAGS="-lc++" make

get-bc fuzz

${ANGORA_LOC}/bin/angora-clang++ fuzz.bc -o ${ANGORA_LOC}/subjects/re2.fast
mv FuncInfo.txt ${ANGORA_LOC}/FInfos/FuncInfo-re2.txt
USE_TRACK=1  ${ANGORA_LOC}/bin/angora-clang++ fuzz.bc -o ${ANGORA_LOC}/subjects/re2.tt
