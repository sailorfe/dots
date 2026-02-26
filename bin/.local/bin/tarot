#!/usr/bin/env bash
set -euo pipefail

pips=(Ace Two Three Four Five Six Seven Eight Nine Ten Page Knight Queen King)
suits=(Swords Cups Wands Coins)
majors=(
  'The Fool' 'The Magician' 'The High Priestess' 'The Empress' 'The Emperor' 'The Hierophant'
  'The Lovers' 'The Chariot' 'Strength' 'The Hermit' 'Wheel of Fortune' 'Justice' 'The Hanged Man'
  'Death' 'Temperance' 'The Devil' 'The Tower' 'The Star' 'The Moon' 'The Sun' 'Judgment' 'The World'
)

deck() {
  minors=()
  for pip in "${pips[@]}"; do
    for suit in "${suits[@]}"; do
      minors+=("$pip of $suit")
    done
  done
  arcana=("${minors[@]}" "${majors[@]}")
}

draw() {
  local num_cards=$1
  local allow_reversed=$2
  local drawn=()

  mapfile -t drawn < <(shuf -e -n "$num_cards" "${arcana[@]}")

  if [[ "$allow_reversed" == "true" ]]; then
    for i in "${!drawn[@]}"; do
      if ((RANDOM % 2)); then
        drawn[i]+=" Reversed"
      fi
    done
  fi

  for card in "${drawn[@]}"; do
    echo "$card"
  done
}

if [[ $# -lt 1 ]]; then
  echo "Usage: $0 [-r] <number_of_cards>"
  exit 1
fi

reversed_flag="false"

if [[ $1 == "-r" ]]; then
  reversed_flag="true"
  shift
fi

num_cards="$1"

deck
draw "$num_cards" "$reversed_flag"
