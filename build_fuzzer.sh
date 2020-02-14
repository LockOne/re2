ANGORA_LOC=/local_home/cheong/Angora_func

make clean
rm fuzz fuzz.bc fuzz.fast fuzz.o fuzz.tt
LDFLAGS="-lc++" CXX=gclang++ CXXFLAGS="-v -stdlib=libc++ -I/usr/include/c++/8 -I/usr/include/c++/8" make

get-bc fuzz

#LDFLAGS="-lc++"
CXXFLAGS="-v -stdlib=libc++ -I/usr/include/c++/8 -I/usr/include/c++/8" ${ANGORA_LOC}/bin/angora-clang++ fuzz.bc -o ${ANGORA_LOC}/subjects/re2.fast
mv FuncInfo.txt ${ANGORA_LOC}/FInfos/FuncInfo-re2.txt
#LDFLAGS="-lc++"
CXXFLAGS="-v -stdlib=libc++ -I/usr/include/c++/8 -I/usr/include/c++/8" USE_TRACK=1  ${ANGORA_LOC}/bin/angora-clang++ fuzz.bc -o ${ANGORA_LOC}/subjects/re2.tt
