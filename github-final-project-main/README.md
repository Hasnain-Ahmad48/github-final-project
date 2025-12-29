#!/usr/bin/env bash
#
# Simple Interest Calculator (v2.4)
# -------------------------------------------------
# Formula:
#   SI = (P × R × T) / 100
#   Total Amount = P + SI
#
# Authors:
#   Upkar Lidder (IBM)
#   Hasnain Ahmad
#
# Disclaimer:
#   Educational use only.
# -------------------------------------------------

set -euo pipefail

trap 'echo -e "\n❌ Interrupted. Exiting safely."; exit 1' INT

# ------------------------------
# Validate numeric input
# ------------------------------
validate_input() {
  local value="$1"
  [[ "$value" =~ ^[0-9]+([.][0-9]+)?$ ]] && awk "BEGIN{exit !($value>0)}"
}

# ------------------------------
# Read input safely (retry)
# ------------------------------
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

# ------------------------------
# Calculate interest
# ------------------------------
calculate_interest() {
  awk "BEGIN { printf \"%.2f\", ($1 * $2 * $3) / 100 }"
}

# ------------------------------
# Header
# ------------------------------
echo "================================================="
echo "        💰 Simple Interest Calculator v2.4"
echo "================================================="

# ------------------------------
# Inputs
# ------------------------------
principal=$(read_input "Enter Principal Amount (P): " "Principal")
rate=$(read_input "Enter Annual Interest Rate (%) (R): " "Rate")
time=$(read_input "Enter Time Period in Years (T): " "Time")

read -rp "Enter Currency Symbol [Default: $]: " currency
currency=${currency:-$}

# ------------------------------
# Calculations
# ------------------------------
simple_interest=$(calculate_interest "$principal" "$rate" "$time")
total_amount=$(awk "BEGIN { printf \"%.2f\", $principal + $simple_interest }")

# ------------------------------
# Output
# ------------------------------
echo
echo "------------------- 📊 Result --------------------"
printf "Principal Amount     : %s%s\n" "$currency" "$principal"
printf "Interest Rate        : %s%%\n" "$rate"
printf "Time Period          : %s years\n" "$time"
echo "-------------------------------------------------"
printf "Simple Interest      : %s%s\n" "$currency" "$simple_interest"
printf "Total Amount         : %s%s\n" "$currency" "$total_amount"
echo "-------------------------------------------------"

# ------------------------------
# User Confirmation
# ------------------------------
read -rp "Enter your name: " user_name
echo "✅ Calculation completed successfully, $user_name!"

exit 0
