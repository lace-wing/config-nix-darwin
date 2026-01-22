#!/bin/bash

words_q=(
  icon.drawing=off
  label="Oh my bitter color ardor wander"
)

sketchybar --add item words_q q \
  --set words_q "${words_q[@]}"
