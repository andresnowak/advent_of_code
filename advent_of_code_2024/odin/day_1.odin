package main

import "core:fmt"
import "core:math"
import "core:os"
import "core:slice"
import "core:strconv"
import "core:testing"

main :: proc() {
	input, _ := os.read_entire_file("day_1_input.txt")
	result := execute(input)
	fmt.println(result)
	// part 2
	result = execute2(input)
	fmt.println(result)
}

execute :: proc(input: []u8) -> int {
	left_side: [dynamic]int
	right_side: [dynamic]int
	defer delete(left_side)
	defer delete(right_side)

	read_values(&left_side, &right_side, input)

	slice.sort(left_side[:])
	slice.sort(right_side[:])

	suma := 0

	for i in 0 ..< len(left_side) {
		suma += abs(left_side[i] - right_side[i])
	}

	return suma
}

execute2 :: proc(input: []u8) -> int {
	left_side: [dynamic]int
	right_side: [dynamic]int
	defer delete(left_side)
	defer delete(right_side)

	read_values(&left_side, &right_side, input)

	dict: map[int]int
	defer delete(dict)

	for j in right_side {
		dict[j] += 1
	}

	result := 0
	for i in left_side {
		if !(i in dict) {
			dict[i] = 0
		}
		result += i * dict[i]
	}

	return result
}


read_values :: proc(left_side: ^[dynamic]int, right_side: ^[dynamic]int, input: []u8) {
	start := 0
	end := 0
	for c in input {
		if c != '\n' && c != ' ' {
			end += 1
		} else {
			if c == ' ' && start != end {
				append(left_side, strconv.atoi(string(input[start:end])))
			} else if start != end {
				append(right_side, strconv.atoi(string(input[start:end])))
			}
			end += 1
			start = end
		}
	}

	append(right_side, strconv.atoi(string(input[start:end])))
}
