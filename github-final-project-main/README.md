#!/usr/bin/env bash
#
# Simple Interest Calculator (v2.3)
# -------------------------------------------------
# Calculates Simple Interest using:
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
#   This script is intended for educational purposes only.
#   Do NOT use in real financial or production environments.
#
# © 2025 Hasnain Ahmad — All Rights Reserved
# -------------------------------------------------

set -euo pipefail

# Graceful exit on Ctrl+C
trap 'echo -e "\n❌ Operation cancelled by user. Exiting safely."; exit 1' INT

# ------------------------------
# Function: validate_input
# Purpose : Ensure positive, non-zero numeric input
# ------------------------------
validate_input() {
  local value="$1"
  local field="$2"

  if ! [[ "$value" =~ ^[0-9]+([.][0-9]+)?$ ]] || (( $(awk "BEGIN {print ($value <= 0)}") )); then
    echo "❌ Invalid Input: $field must be a positive number greater than 0." >&2
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
# Application Header
# ------------------------------
echo "================================================="
echo "        💰 Simple Interest Calculator v2.3"
echo "================================================="

# ------------------------------
# Collect User Inputs
# ------------------------------
read -rp "Enter Principal Amount (P): " principal
validate_input "$principal" "Principal Amount"

read -rp "Enter Annual Interest Rate (%) (R): " rate
validate_input "$rate" "Interest Rate"

read -rp "Enter Time Period in Years (T): " time
validate_input "$time" "Time Period"

read -rp "Enter Currency Symbol (e.g., $, Rs) [Default: $]: " currency
currency=${currency:-$}

# ------------------------------
# Perform Calculation
# ------------------------------
simple_interest=$(calculate_interest "$principal" "$rate" "$time")

# ------------------------------
# Display Result
# ------------------------------
echo
echo "------------------- 📊 Result --------------------"
printf "Principal Amount     : %s%s\n" "$currency" "$principal"
printf "Interest Rate        : %s%%\n" "$rate"
printf "Time Period          : %s years\n" "$time"
echo "-------------------------------------------------"
printf "Simple Interest (SI) : %s%s\n" "$currency" "$simple_interest"
echo "-------------------------------------------------"

# ------------------------------
# User Confirmation
# ------------------------------
read -rp "Enter your name (camelCase preferred): " user_name
echo "✅ Calculation completed successfully. Thank you, $user_name!"

exit 0
