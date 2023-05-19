#!/bin/bash

# Define color codes
RED='\033[0;31m'
LIGHTRED='\033[1;31m' # Bright Red
GREEN='\033[0;32m'
LIGHTGREEN='\033[1;32m'
NC='\033[0m' # No Color

run_test() {
    local input_sequence="$1"
    local expected_output="$2"

    # Run the program with the input sequence and capture its output
    local actual_output=$(./PmergeMe $input_sequence)

    # Check if the output contains "Error" and matches the expected output
    if [[ $expected_output == *"Error"* ]]; then
        if [[ $actual_output == *"Error"* ]]; then
            echo -e "${LIGHTGREEN}Test passed: ${GREEN} $input_sequence"
        else
            echo -e "${LIGHTRED}Test failed: ${RED} $input_sequence"
            echo "Expected:"
            echo -e "$expected_output"
            echo "Got:"
            echo -e "$actual_output${NC}"
        fi
    else
        # Remove the "After: " part from the expected output
        expected_output=$(echo "$expected_output" | sed 's/After: //')

        # Check if the output contains "Before: " followed by the input sequence
        if [[ $actual_output == *"Before: $input_sequence"* ]]; then
            # Extract the ordered sequence from the output
            local ordered_sequence=$(echo "$actual_output" | awk '/After: /{print $NF}')
            
            # Check if the output contains "After: " followed by the expected ordered sequence
            if [[ $actual_output == *"After: $expected_output"* ]]; then
                echo -e "${LIGHTGREEN}Test passed: ${GREEN} $input_sequence"
            else
                echo -e "${LIGHTRED}Test failed: ${RED} $input_sequence"
                echo "Expected:"
                echo -e "After: $expected_output"
                echo "Got:"
                echo -e "After: $ordered_sequence${NC}"
            fi
        else
            echo -e "${LIGHTRED}Test failed: ${RED} $input_sequence"
            echo "Expected:"
            echo -e "Before: $input_sequence"
            echo "Got:"
            echo -e "$actual_output${NC}"
        fi
    fi
}

# Define test cases
test_case1=("1 3 2 5 4 a" "Error")
test_case2=("1 3 2 -5 4" "Error")
test_case3=("1 3 2 5 4 5" "Error")
test_case4=("1 3 2 5 4" "1 2 3 4 5")
test_case5=("2 3 1 5 4" "1 2 3 4 5")
test_case6=("5 3 1 2 4" "1 2 3 4 5")

# Run the test cases
run_test "${test_case1[0]}" "${test_case1[1]}"
run_test "${test_case2[0]}" "${test_case2[1]}"
run_test "${test_case3[0]}" "${test_case3[1]}"
run_test "${test_case4[0]}" "${test_case4[1]}"
run_test "${test_case5[0]}" "${test_case5[1]}"
run_test "${test_case6[0]}" "${test_case6[1]}"
