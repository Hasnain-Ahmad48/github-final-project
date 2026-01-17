#!/usr/bin/env bash
#
# Simple Interest Calculator (v2.5)
# -------------------------------------------------
# Calculates Simple Interest and Total Amount
#
# Formula:
#   Simple Interest (SI) = (P × R × T) / 100
#   Total Amount        = P + SI
#
# Authors:
#   Upkar Lidder (IBM)
#   Hasnain Ahmad
#
# Disclaimer:
#   This script is for educational purposes only.
#   Not intended for financial or production use.
# -------------------------------------------------

set -euo pipefail

# Handle Ctrl+C gracefully
trap 'echo -e "\n❌ Operation cancelled by user. Exiting safely."; exit 1' INT

# -------------------------------------------------
# Function: validate_input
# Purpose : Validate positive numeric input
# -------------------------------------------------
validate_input() {
  local value="$1"
  [[ "$value" =~ ^[0-9]+([.][0-9]+)?$ ]] && awk "BEGIN { exit !($value > 0) }"
}

# -------------------------------------------------
# Function: read_input
# Purpose : Read input with retry until valid
# -------------------------------------------------
read_input() {
  local prompt="$1"
  local field="$2"
  local value

  while true; do
    read -rp "$prompt" value
    if validate_input "$value"; then
      echo "$value"
      return
    else
      echo "❌ Invalid $field. Please enter a positive number."
    fi
  done
}

# -------------------------------------------------
# Function: calculate_interest
# -------------------------------------------------
calculate_interest() {
  awk "BEGIN { printf \"%.2f\", ($1 * $2 * $3) / 100 }"
}

# -------------------------------------------------
# UI Header
# -------------------------------------------------
echo "================================================="
echo "        💰 Simple Interest Calculator v2.5"
echo "================================================="

# -------------------------------------------------
# User Inputs
# -------------------------------------------------
principal=$(read_input "Enter Principal Amount (P): " "Principal Amount")
rate=$(read_input "Enter Annual Interest Rate (%) (R): " "Interest Rate")
time=$(read_input "Enter Time Period in Years (T): " "Time Period")

read -rp "Enter Currency Symbol [Default: $]: " currency
currency=${currency:-$}

# -------------------------------------------------
# Calculations
# -------------------------------------------------
simple_interest=$(calculate_interest "$principal" "$rate" "$time")
total_amount=$(awk "BEGIN { printf \"%.2f\", $principal + $simple_interest }")

# -------------------------------------------------
# Output
# -------------------------------------------------
echo
echo "------------------- 📊 Result --------------------"
printf "Principal Amount     : %s%s\n" "$currency" "$principal"
printf "Interest Rate        : %s%%\n" "$rate"
printf "Time Period          : %s years\n" "$time"
echo "-------------------------------------------------"
printf "Simple Interest      : %s%s\n" "$currency" "$simple_interest"
printf "Total Amount         : %s%s\n" "$currency" "$total_amount"
echo "-------------------------------------------------"

# -------------------------------------------------
# User Confirmation
# -------------------------------------------------
read -rp "Enter your name: " user_name
echo
echo "✅ Calculation completed successfully."
echo "Thank you for using the calculator, $user_name!"

exit 0
