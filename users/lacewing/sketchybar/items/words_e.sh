#!/bin/bash

words_e=(
  icon.drawing=off
  label="Gotta feel it undercover"
)

sketchybar --add item words_e e \
  --set words_e "${words_e[@]}"
