#!/bin/bash
if ip route | grep default | grep -q via; then
  echo "󰤨 "
else
  echo "󰤭 "
fi

