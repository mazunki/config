function s() {
  scp ~/.bashrc $1:/tmp/.bashrc_temp > /dev/null
  ssh -t $1 "bash --rcfile /tmp/.bashrc_temp; rm /tmp/.bashrc_temp"
}