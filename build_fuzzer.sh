#!/bin/bash
#https://github.com/LockOne/re2.git

FUZZER=${FUZZER:-ANGORA}

ANGORA_LOC="/local_home/cheong/Angora_func"
AFL_LOC="/local_home/cheong/aflfast"

if [ ${FUZZER} = "ANGORA" ]; then
  FUZZER_LOC=${ANGORA_LOC}
else
  FUZZER_LOC=${AFL_LOC}
fi

ASAN=${ASAN:-FALSE}

ASANFLAGS=""

if [ ${ASAN} != "FALSE" ]; then
  ASANFLAGS="ANGORA_DONT_OPTIMIZE=1 ANGORA_USE_ASAN=1"
fi

rm ${FUZZER_LOC}/re2*

mkdir ${FUZZER_LOC}/subjects
mkdir ${FUZZER_LOC}/FInfos

make clean
rm fuzz fuzz.bc fuzz.fast fuzz.o fuzz.tt
#debian
#LDFLAGS="-lc++" CXX=gclang++ CXXFLAGS="-stdlib=libc++" make
#ubuntu - fairfuzz?
LDFLAGS="-lc++" CXX=gclang++ CXXFLAGS="-std=c++11 -stdlib=libstdc++" make

get-bc fuzz

if [ ${FUZZER} = "ANGORA" ]; then
  (export LDFLAGS="-lc++" ${ASANFLAGS} CXXFLAGS="-stdlib=libc++" ; /local_home/cheong/Angora_func/bin/angora-clang++ fuzz.bc -o ${ANGORA_LOC}/subjects/re2.fast)
  #LDFLAGS="-lc++" ${ASANFLAGS} CXXFLAGS="-std=c++11 -stdlib=libstdc++" /local_home/cheong/Angora_func/bin/angora-clang++ fuzz.bc -o ${ANGORA_LOC}/subjects/re2.fast
  mv FuncInfo.txt ${ANGORA_LOC}/FInfos/FuncInfo-re2.txt || true
  LDFLAGS="-lc++" CXXFLAGS="-stdlib=libc++" USE_TRACK=1  /local_home/cheong/Angora_func/bin/angora-clang++ fuzz.bc -o ${ANGORA_LOC}/subjects/re2.tt
  #LDFLAGS="-lc++" CXXFLAGS="std=c++11 -stdlib=libstdc++" USE_TRACK=1  /local_home/cheong/Angora_func/bin/angora-clang++ fuzz.bc -o ${ANGORA_LOC}/subjects/re2.tt
else
  #LDFLAGS="-lc++" CXXFLAGS="-stdlib=libc++" ${FUZZER_LOC}/afl-clang-fast++ fuzz.bc -lpthread -o ${FUZZER_LOC}/subjects/re2.afl
  LDFLAGS="-lc++" CXXFLAGS="-std=c++11 -stdlib=libstdc++" ${FUZZER_LOC}/afl-clang-fast++ fuzz.bc -lpthread -o ${FUZZER_LOC}/subjects/re2.afl
  mv FuncInfo.txt ${FUZZER_LOC}/FInfos/FuncInfo-re2.txt || true
fi
