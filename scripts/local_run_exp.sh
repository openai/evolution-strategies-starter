#!/bin/sh
NAME=exp_`date "+%m_%d_%H_%M_%S"`
EXP_FILE=$1
tmux new -s $NAME -d
tmux send-keys -t $NAME '. scripts/local_env_setup.sh' C-m
tmux send-keys -t $NAME 'python -m es_distributed.main master --master_host localhost --exp_file '"$EXP_FILE" C-m
tmux split-window -t $NAME
tmux send-keys -t $NAME '. scripts/local_env_setup.sh' C-m
tmux send-keys -t $NAME 'python -m es_distributed.main workers --master_host localhost --relay_socket_path /tmp/redis.sock --num_workers 1' C-m
tmux a -t $NAME
