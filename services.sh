#!/usr/bin/env bash

source script-env.sh

# Usage: enable_service <service_name> <is_user_service>
# <is_user_service> should be "true" for --user, anything else for system

declare RELOADED_SYSTEM=
declare RELOADED_USER=

enable_service() {
  local service_name=$1
  local is_user_service=${2:-false}
  local systemctl_flag=""
  local reload_marker="RELOADED_SYSTEM"

  if [[ $is_user_service == "true" ]]; then
    systemctl_flag="--user"
    reload_marker="RELOADED_USER"
  fi

  # reload once per mode, only if successful
  if [[ -z ${!reload_marker} ]]; then
    if systemctl $systemctl_flag daemon-reload; then
      declare "$reload_marker=1"
    else
      echo "Failed to reload systemd daemon ($systemctl_flag)" >&2
      return 1
    fi
  fi

  # enable & start if not already enabled
  if ! systemctl $systemctl_flag is-enabled "$service_name" &>/dev/null; then
    echo "$service_name"
    systemctl $systemctl_flag enable --now "$service_name"
  fi
}

# system services
enable_service "bluetooth.service"
enable_service "betterlockscreen@$(logname).service"

# user services
enable_service "battery-notify.timer" true
enable_service "mpris-proxy.service" true
