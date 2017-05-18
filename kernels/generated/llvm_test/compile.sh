FILES=*.cl
for f in $FILES
do
  clang -S -emit-llvm -o $f.ll -x cl $f
done
