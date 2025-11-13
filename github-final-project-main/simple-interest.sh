#!/usr/bin/env bash
#
# Simple Interest Calculator
# This script calculates simple interest given principal, annual rate of interest, and time period in years.
# For sample/educational purposes only – not intended for production use.
#
# Author: Upkar Lidder (IBM)
# Additional Author: Hasnain Ahmad
# ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
# Inputs:
#   P = principal amount
#   R = annual rate of interest (percentage)
#   T = time period in years
# Output:
#   Simple interest = P × R × T / 100
#
# All Rights Reserved by Hasnain Ahmad
# ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––

set -euo pipefail  # safer bash settings

# Read principal
read -rp "Enter the principal amount (P): " principal

# Validate principal is a positive number
if ! [[ "$principal" =~ ^[0-9]+([.][0-9]+)?$ ]]; then
  echo "Error: Principal must be a valid positive number." >&2
  exit 1
fi

# Read annual interest rate
read -rp "Enter the annual rate of interest (in %, R): " rate

# Validate rate is a positive number
if ! [[ "$rate" =~ ^[0-9]+([.][0-9]+)?$ ]]; then
  echo "Error: Rate of interest must be a valid positive number." >&2
  exit 1
fi

# Read time period in years
read -rp "Enter the time period in years (T): " time_years

# Validate time period is a positive number
if ! [[ "$time_years" =~ ^[0-9]+([.][0-9]+)?$ ]]; then
  echo "Error: Time period must be a valid positive number." >&2
  exit 1
fi

# Calculate simple interest
simple_interest=$(awk "BEGIN { printf \"%.2f\", ($principal * $rate * $time_years) / 100 }")

echo
echo "Calculation result:"
echo "Principal (P)      : $principal"
echo "Rate of interest (R): $rate%"
echo "Time period (T)    : $time_years years"
echo "Simple interest    : $simple_interest"

# Additional prompt for name (camelCase)
read -rp "Enter your name in camelCase: " userName

echo "Thank you, $userName. Script completed."

exit 0
