#!/bin/bash

# Define color codes
RED='\033[0;31m'
LIGHTRED='\033[1;31m' # Bright Red
GREEN='\033[0;32m'
LIGHTGREEN='\033[1;32m'
NC='\033[0m' # No Color

run_test() {
    local input_file="$1"
    local expected_output="$2"

    # Get the line from the input file
    local input_line=$(cat "$input_file")

    # Run the program with the input file and capture its output
    local actual_output=$(./btc "$input_file")

    # Check if the output contains "Error" and matches the expected output
    if [[ $expected_output == *"Error"* ]]; then
        if [[ $actual_output == *"Error"* ]]; then
            echo -e "${LIGHTGREEN}Test passed: ${GREEN}\n'$input_line'\n"
        else
            echo -e "${LIGHTRED}Test failed: ${RED}\n'$input_line'\n"
            echo "Expected:"
            echo -e "$expected_output"
            echo "Got:"
            echo -e "$actual_output${NC}\n"
        fi
    else
        # Check for exact match
        if [ "$actual_output" = "$expected_output" ]; then
            echo -e "${LIGHTGREEN}Test passed: ${GREEN}\n'$input_line'\n"
        else
            echo -e "${LIGHTRED}Test failed: ${RED}\n'$input_line'\n"
            echo "Expected:"
            echo -e "$expected_output"
            echo "Got:"
            echo -e "$actual_output${NC}\n"
        fi
    fi
}

# Create dynamic input files
input_file1=$(mktemp)
input_file2=$(mktemp)
input_file3=$(mktemp)
input_file4=$(mktemp)
input_file5=$(mktemp)
input_file6=$(mktemp)
input_file7=$(mktemp)
input_file8=$(mktemp)
input_file9=$(mktemp)
input_file10=$(mktemp)
input_file11=$(mktemp)
input_file12=$(mktemp)
input_file13=$(mktemp)
input_file14=$(mktemp)
input_file15=$(mktemp)
input_file16=$(mktemp)
input_file17=$(mktemp)

# Generate input content for each file
echo -e "date | value\n2011-01-03 | 3" > "$input_file1"
echo -e "date | value\n2011-01-03 | -1" > "$input_file2"
echo -e "date | value\n2012-01-11 | 2147483648" > "$input_file3"
echo -e "date | value\n900-12-12 | 12" > "$input_file4"
echo -e "date | value\n2021-09-27| 431.63|2" > "$input_file5"
echo -e "date | value\n2021-10-03" > "$input_file6"
echo -e "date | value\n2020-02-29 | 42" > "$input_file7"
echo -e "date | value\n2012-12-12 | | 55.1" > "$input_file8"
echo -e "date | value\n2011-01-03 | 1" > "$input_file9"
echo -e "date | value\n2021-09-15| 47" > "$input_file10"
echo -e "date | value\n2001-09-15 | 47" > "$input_file11"
echo -e "date | value\n2012-12-12 | 55.." > "$input_file12"
echo -e "date | value\n2012-12-12 | .5.5" > "$input_file13"
echo -e "date | value\n2012-12-12 | 5" > "$input_file14"
echo -e "date | value\n2011-01-03 | 1.2" > "$input_file15"
echo -e "date | value\n2012-01-11 | 1" > "$input_file16"
echo -e "date | value\n2001-42-42" > "$input_file17"

# Define expected outputs
expected_output1="2011-01-03 => 3 = 0.9"
expected_output2="Error: bad input => -1"
expected_output3="Error: too large a number"
expected_output4="Error: bad input => 900-12-12"
expected_output5="Error: bad input => 431.63|2"
expected_output6="Error: bad input =>"
expected_output7="2020-02-29 => 42 = 365918.7"
expected_output8="Error: bad input => |55.1"
expected_output9="2011-01-03 => 1 = 0.3"
expected_output10="2021-09-15 => 47 = 2212389.64"
expected_output11="Error: bad input"
expected_output12="Error: bad input => 55.."
expected_output13="Error: bad input => .5.5"
expected_output14="2012-12-12 => 5 = 69"
expected_output15="2011-01-03 => 1.2 = 0.36"
expected_output16="2012-01-11 => 1 = 7.1"
expected_output17="Error: bad input => "

# Run the test cases
run_test "$input_file1" "$expected_output1"
run_test "$input_file2" "$expected_output2"
run_test "$input_file3" "$expected_output3"
run_test "$input_file4" "$expected_output4"
run_test "$input_file5" "$expected_output5"
run_test "$input_file6" "$expected_output6"
run_test "$input_file7" "$expected_output7"
run_test "$input_file8" "$expected_output8"
run_test "$input_file9" "$expected_output9"
run_test "$input_file10" "$expected_output10"
run_test "$input_file11" "$expected_output11"
run_test "$input_file12" "$expected_output12"
run_test "$input_file13" "$expected_output13"
run_test "$input_file14" "$expected_output14"
run_test "$input_file15" "$expected_output15"
run_test "$input_file16" "$expected_output16"
run_test "$input_file17" "$expected_output17"

# Clean up dynamic input files
rm "$input_file1" "$input_file2" "$input_file3" "$input_file4" "$input_file5" "$input_file6" "$input_file7" "$input_file8" "$input_file9" "$input_file10" "$input_file11"  "$input_file12" "$input_file13"  "$input_file14" "$input_file15" "$input_file16" "$input_file17"