#!/bin/bash

num=0

for file in `ls -1 *.png`; do
  mv "$file" "$num.png"
  let "num += 1"
done