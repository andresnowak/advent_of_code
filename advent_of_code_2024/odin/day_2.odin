package main

import "core:fmt"
import "core:os"
import "core:strconv"

main :: proc() {
	input, _ := os.read_entire_file("day_2_input.txt")

	result := execute_1(input)
	fmt.println(result)

	result = execute_2(input)
	fmt.println(result)
}

execute_1 :: proc(input: []u8) -> int {
	lista: [dynamic][dynamic]int
	defer delete(lista)

	process_input(&lista, string(input))

	before := -1
	difference := -1
	flag := true

	result := 0
	for i in lista {
	    if len(i) == 0 {
            continue
        }

        for j in i {
            if before == -1 {
                before = j
                continue
            }

            temp := before - j
            if abs(temp) > 3 || abs(temp) == 0 {
                flag = false
                break
            }

            if difference == -1 {
                difference = 0 if temp < 0 else 1
            } else if temp > 0 && difference == 0 || temp < 0 && difference == 1 {
                flag = false
                break
            }

            before = j
        }

        if flag {
            result += 1
        }

        before = -1
        difference = -1
        flag = true
    }

	return result
}

execute_2 :: proc(input: []u8) -> int {
	lista: [dynamic][dynamic]int
	defer delete(lista)

	process_input(&lista, string(input))

	// --------

	result := 0
	for i in lista {
		j := 0

		if len(i) == 0 {
		    continue
		}

		for j in -1..<len(i) {
    		check_wrong :: proc(temp: int, difference: ^int) -> bool {
    			if abs(temp) > 3 || abs(temp) == 0 {
    				return false
    			}

    			if difference^ == -1 {
    				difference^ = 0 if temp < 0 else 1
    			} else if temp > 0 && difference^ == 0 || temp < 0 && difference^ == 1 {
    				return false
    			}
    			return true
    		}

    		before := -1
    		difference := -1
    		flag := true

            for k in 0..<len(i) {
                if k == j {
                    continue
                }
                if before == -1 {
                    before = i[k]
                    continue
                }

                temp := before - i[k]
                if !check_wrong(temp, &difference) {
                    flag = false
                    break
                }

                before = i[k]
            }

            if flag {
                result += 1
                break
            }
        }
	}


	return result
}

process_input :: proc(list_of_lists: ^[dynamic][dynamic]int, input: string) {
    append(list_of_lists, make([dynamic]int)); // Initialize the first sublist
    start := 0;
    end := 0;

    for i in 0..<len(input) {
        if input[i] == ' ' {
            // Append the parsed number to the current sublist
            append(&(list_of_lists^)[len(list_of_lists^) - 1], strconv.atoi(string(input[start:end])));
        }

        if input[i] == '\n' {
            // Append the parsed number to the current sublist
            append(&(list_of_lists^)[len(list_of_lists^) - 1], strconv.atoi(string(input[start:end])));
            // Start a new sublist
            append(list_of_lists, make([dynamic]int));
        }

        end += 1;
        // Reset start position after processing a separator
        if input[i] == ' ' || input[i] == '\n' {
            start = end;
        }
    }

    // Handle any remaining input at the end of the string
    if start < end {
        append(&(list_of_lists^)[len(list_of_lists^) - 1], strconv.atoi(string(input[start:end])));
    }
}
