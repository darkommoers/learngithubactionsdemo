#!/bin/sh
#
set -e

info() {
  local color='\033[1;32m'
  local clear='\033[0m'
  local time=$(date '+%F %T')
  printf "${color}[${time}] [INFO]: ${clear}%s\n" "$*"
}

warn() {
  local color='\e[1;33m'
  local clear='\e[0m'
  local time=$(date '+%Y-%m-%d %T')
  printf "${color}[${time}] [WARN]: ${clear}%s\n" "$*"
}

error() {
  local color='\e[1;31m'
  local clear='\e[0m'
  local time=$(date +"%Y-%m-%d %H:%M:%S")
  printf "${color}[${time}] [ERROR]: ${clear}%s\n" "$*"
}

graceful_stop() {
  trap '' EXIT
  warn "graceful stopping wireguard..."
  wg-quick down "$@"
  info "graceful stopping wireguard Complete..."
}

start_wireguard() {
  trap 'graceful_stop "$@"' INT QUIT TERM KILL
  # trap "graceful_stop \"$@\"" INT QUIT TERM KILL
  info "starting wireguard..."
  trap 'error "starting wireguard Error..."' EXIT
  wg-quick up "$@"
  if [ $? -eq 0 ]; then info "starting wireguard Complete..."; fi
}

start_wireguard "$@"
# Keep the script running to keep the container alive
read REPLY
