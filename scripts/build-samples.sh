#!/bin/bash

example_name=$1

[ "$example_name" == "" ] && echo "usage: $0 <example name ie BellState>" && exit 1

set -x

ssh_command="cd C:\Users\vagrant\qsharp-compiler\examples\QIR\\$example_name && dotnet build"

pushd vagrant
ssh default $ssh_command
scp "default:C:\Users\vagrant\qsharp-compiler\examples\QIR\\$example_name\Program.qs" ../data/$example_name.program.qs
scp "default:C:\Users\vagrant\qsharp-compiler\examples\QIR\\$example_name\qir\\$example_name.ll" ../data
popd
pushd data
llvm-as $example_name.ll