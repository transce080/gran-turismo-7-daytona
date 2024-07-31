#!/bin/bash

# Gran Turismo 7 Daytona Autopilot Script

# This work © 2024 by Jason Lonsberry is licensed under CC BY-NC-SA 4.0.
# To view a copy of this license, visit https://creativecommons.org/licenses/by-nc-sa/4.0/

set -e
trap exit_gracefully SIGINT

# To prevent sleep, launch with systemd-inhibit

# ---------- dependencies ----------

if ! dpkg -s wmctrl >/dev/null 2>&1; then
  sudo apt install wmctrl
fi
if ! dpkg -s xdotool >/dev/null 2>&1; then
  sudo apt install xdotool
fi

# ---------- functions ----------

add() {
  echo "scale=1; $1 + $2" | bc
}

multiply() {
  echo "$1 * $2" | bc
}

hold() {
  xdotool search --name "$WINDOW_NAME" keydown "$1"
}

release() {
  xdotool search --name "$WINDOW_NAME" keyup "$1"
}

press() {
  xdotool search --name "$WINDOW_NAME" keydown "$1"
  sleep $KEYPRESS_LENGTH
  xdotool search --name "$WINDOW_NAME" keyup "$1"
}

exit_gracefully() {
  printf "\nQuitting \n"
  release $KEY_ANA_L
  release $KEY_DPAD_R
  release $KEY_R2
  release $KEY_X
  exit
}

# ---------- config ----------

LAPS=10
LAP_MILES=2.6
RACE_PRIZE=8520
RACE_TIME=531

# ---------- key config ----------
# Key config MUST be set to match your Chiaki key config

KEY_DPAD_R='Right' # default 'Right'
KEY_R2='4'         # default '4'
KEY_X='Return'     # default 'Return'
KEY_ANA_L='['      # default '['

# ---------- constants ----------

KEYPRESS_LENGTH=0.08
RACE_MILES=$(multiply $LAP_MILES $LAPS)
WINDOW_NAME='Chiaki | Stream'

# ---------- main  ----------

current_miles=0.0
current_money=0
race_count=0
SECONDS=0

if ! wmctrl -l|grep "$WINDOW_NAME" >/dev/null 2>&1; then
  echo 'The Chiaki stream window was not found. Quitting'
  exit
fi

hold $KEY_R2

while true
do
  race_count=$(($race_count + 1))

  echo "Race $race_count"
  press $KEY_X
  sleep 8

  echo "  Racing"
  for lap in $(seq 1 $RACE_TIME); do
    press $KEY_ANA_L
    sleep 1
  done

  echo "  Race ending"
  sleep 30

  echo "Standings"
  sleep 20 # extra wait here to buffer for slow finishes
  press $KEY_X

  echo "Rewards"
  press $KEY_X
  echo "  Elapsed: $(($SECONDS / 360))h ($SECONDS / 60))m $(($SECONDS % 60))s"
  sleep 3

  current_miles=$(add $current_miles $RACE_MILES)
  current_money=$((current_money + RACE_PRIZE * LAPS))

  printf "  Credits: %'d\n" $current_money
  press $KEY_X
  sleep 2

  echo "  Miles: $current_miles"
  press $KEY_X
  sleep 4

  echo "Replay"
  press $KEY_X
  sleep 4
  press $KEY_X
  sleep 2
  press $KEY_X
  press $KEY_X
  sleep 5

  echo "Retry"
  press $KEY_DPAD_R
  sleep 1
  press $KEY_X
  sleep 4
done
