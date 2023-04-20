#!/bin/bash

if [ $# -lt 1 ]
then
  echo "Usage: $0 <filename>"
  exit 1
fi

filename="$1"
commands=("check" "show" "run")

for command in "${commands[@]}"
do
  outputfile="$command.txt"
  java -cp alloy4.2.jar AlloyCommandPrompt $filename $command > $outputfile
done
