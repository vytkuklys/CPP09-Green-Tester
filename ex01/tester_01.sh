#!/bin/bash

# Define color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# Function to run a test case
run_test() {
    local input="$1"
    local expected_output="$2"

    # Run the program and capture its output
    local actual_output=$(./RPN "$input")

    # Check if the output matches the expected output
    if [ "$actual_output" = "$expected_output" ]; then
        echo -e "${GREEN}Test passed: ./RPN $input${NC}"
    else
        echo -e "${RED}Test failed: ./RPN $input"
        echo "Expected: $expected_output"
        echo "Got: $actual_output${NC}"
    fi
}

# Run some test cases

# Simple tests
for i in {0..9}; do
    run_test "$i" "$i"
done

# Simple operations
run_test "1 2 +" "3"
run_test "4 3 -" "1"
run_test "2 3 *" "6"
run_test "6 3 /" "2"
run_test "6 3/" "2"

# More complex operations
run_test "2 3 + 4 *" "20"
run_test "2 3 4 * +" "14"
run_test "2 3 + 4 * 5 -" "15"
run_test "9 5 3 + 2 4 * + -" "-7"
run_test "1 2 * 2 / 2 + 5 * 6 - 1 3 * - 4 5 * * 8 /" "15"
run_test "9 8 * 4 * 4 / 2 + 9 - 8 - 8 - 1 - 6 -" "42"
run_test "8 9 * 9 - 9 - 9 - 4 - 1 +" "42"

# Operations with negative results
run_test "2 3 -" "-1"
run_test "3 2 1 - -" "2"

# Operations with large numbers
run_test "99999999 1 *" "99999999"

# Invalid operations
for i in {0..9}; do
    run_test "$i +" "Error"
    run_test "$i -" "Error"
    run_test "$i *" "Error"
    run_test "$i /" "Error"
done

# Operations with too many numbers
run_test "2 2 2 +" "Error"
run_test "2 +" "Error"
run_test "2 2" "Error"
run_test "2 + -" "Error"
run_test "1 2 + -" "Error"
run_test "+ -" "Error"
run_test "+ 2" "Error"

# Operations with invalid characters
run_test "2 a +" "Error"
run_test "(1 + 1)" "Error"
