#!/usr/bin/env bash
#
# Simple Interest Calculator (v2.0)
# -------------------------------------------------
# This script calculates Simple Interest using:
#   P — Principal Amount
#   R — Annual Interest Rate (%)
#   T — Time Period (Years)
#
# Formula:
#   SI = (P × R × T) / 100
#
# Authors:
#   Upkar Lidder (IBM)
#   Hasnain Ahmad
#
# Disclaimer:
#   This script is intended for learning purposes only.
#   Do NOT use in real financial or production systems.
#
# © 2025 Hasnain Ahmad — All Rights Reserved
# -------------------------------------------------

set -euo pipefail

# Handle Ctrl+C gracefully
trap 'echo -e "\n❌ Process interrupted. Exiting safely."; exit 1' INT

# ------------------------------
# Function: validate_input
# Purpose : Ensure input is a positive non-zero number
# ------------------------------
validate_input() {
  local value="$1"
  local field="$2"

  if ! [[ "$value" =~ ^[0-9]+([.][0-9]+)?$ ]] || (( $(awk "BEGIN {print ($value <= 0)}") )); then
    echo "❌ Error: $field must be a positive number greater than 0." >&2
    exit 1
  fi
}

# ------------------------------
# Function: calculate_interest
# ------------------------------
calculate_interest() {
  awk "BEGIN { printf \"%.2f\", ($1 * $2 * $3) / 100 }"
}

# ------------------------------
# UI Header
# ------------------------------
echo "================================================="
echo "        💰 Simple Interest Calculator v2.0"
echo "================================================="

# Inputs
read -rp "Enter Principal Amount (P): " principal
validate_input "$principal" "Principal Amount"

read
