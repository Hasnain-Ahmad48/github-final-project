#!/usr/bin/env bash
#
# Simple Interest Calculator
# --------------------------------------------
# This script calculates simple interest based on:
#   P — Principal Amount
#   R — Annual Rate of Interest (%)
#   T — Time Duration (Years)
#
# Authors:
#   Upkar Lidder (IBM)
#   Hasnain Ahmad
#
# Note:
#   This script is for educational/demo purposes only.
#   Not intended for production or financial systems.
#
# © All Rights Reserved — Hasnain Ahmad
# --------------------------------------------

set -euo pipefail  # Enable strict bash mode for safety

# ------------------------------
# Function: validate_input
# Description: Validate numeric input (positive number)
# ------------------------------
validate_input() {
  local value="$1"
  local field_name="$2"

  if ! [[ "$value" =~ ^[0-9]+([.][0-9]+)?$ ]]; then
    echo "❌ Error: $field_name must be a valid positive number." >&2
    exit 1
  fi
}

echo "--------------------------------------------"
echo "       Simple Interest Calculator"
echo "--------------------------------------------"

# Read principal
read -rp "Enter the Principal Amount (P): " principal
validate_input "$principal" "Principal Amount"

# Read annual rate
read -rp "Enter the Annual Interest Rate (%) (R): " rate
validate_input "$rate" "Rate of Interest"

# Read time duration
read -rp "Enter the Time Duration in Years (T): " time_years
validate_input "$time_years" "Time Duration"

# Calculate SI
simple_interest=$(awk "BEGIN { printf \"%.2f\", ($principal * $rate * $time_years) / 100 }")

echo
echo "--------------------------------------------"
echo "               Calculation Result"
echo "--------------------------------------------"
echo "Principal (P)          : $principal"
echo "Rate of Interest (R)   : $rate%"
echo "Time Duration (T)      : $time_years years"
echo "--------------------------------------------"
echo "Simple Interest (SI)   : $simple_interest"
echo "--------------------------------------------"

# Ask for user's name (camelCase)
read -rp "Enter your name in camelCase: " userName
echo "Thank you, $userName! Your calculation is complete."

exit 0
