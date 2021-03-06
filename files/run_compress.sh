#!/bin/bash
#run the program
SIM="sim-outorder"

function go_outorder {
date
echo "starting go in-order=$5 width $1, intalu $2, intmult $3, memprt $4"
echo "in-order=$5, width=$1, intalu=$2, intmult=$3, memprt=$4" >> ./outorder/execution_time.txt
/usr/bin/time -a -o ./outorder/runtime.txt $SIM -fetch:ifqsize $1 -decode:width $1 -issue:width $1 -commit:width $1 -res:ialu $2 -res:imult $3 -res:memport $4 -issue:inorder $5 -redir:sim "./outorder/go_stdout_$1_$2_$3_$4_$5.txt" compress95.ss < compress95.in > ./outorder/go_output_$1_$2_$3_$4_$5.txt
echo "done"
echo "running diff on go in-order=$5 width $1, intalu $2, intmult $3, memprt $4"
diff ./outorder/go_output_$1_$2_$3_$4_$5.txt compress95.out
echo "done with diff check"
date
}

function go_pred {
date
echo "starting go in-order=$1, bpred=$2"
/usr/bin/time -a -o ./pred/runtime.txt $SIM -fetch:ifqsize 4 -decode:width 4 -issue:width 4 -commit:width 4 -res:ialu 3 -res:imult 2 -res:memport 2 -issue:inorder $1 -bpred $2 -redir:sim "./pred/pred_$2_$1.txt" compress95.ss < compress95.in > ./pred/pred_output_$2_$1.txt
echo "done"
echo "running diff on go in-order=$1, bpred=$2"
diff ./pred/pred_output_$2_$1.txt compress95.out
echo "done with diff check"
date
}


#run out of order
mkdir outorder
go_outorder 1 1 1 1 "true" &
go_outorder 2 2 1 1 "true" &
go_outorder 4 3 2 2 "true" &
go_outorder 8 6 3 2 "true" &
go_outorder 1 1 1 1 "false" &
go_outorder 2 2 1 1 "false" &
go_outorder 4 3 2 2 "false" &
go_outorder 8 6 3 2 "false"


#run pred
mkdir pred
go_pred "true" "taken" &
go_pred "true" "nottaken" &
go_pred "true" "2lev" &
go_pred "true" "perfect" &
go_pred "false" "taken" &
go_pred "false" "nottaken" &
go_pred "false" "2lev" &
go_pred "false" "perfect"

