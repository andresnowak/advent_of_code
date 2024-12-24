package main

import "core:fmt"
import "core:os"
import "core:text/regex"
import "core:strconv"

main :: proc() {
    input, _ := os.read_entire_file("day_3_input.txt")
    defer delete(input)
    taks1 := find_muls_part_1(string(input))
    fmt.println(taks1)
    taks2 := find_muls_part_2(string(input))
    fmt.println(taks2)
}

find_muls_part_1 :: proc(content: string) -> int {
    re, _ := regex.create("mul\\(\\s*(\\d+)\\s*,\\s*(\\d+)\\s*\\)", flags={.Global})

    total := 0
    idx := 0
    for i in regex.match(re, content[idx:]) {
        total += strconv.atoi(i.groups[1]) * strconv.atoi(i.groups[2])
        idx += i.pos[0][1] // we grab the end of the match
    }

    return total
}

find_muls_part_2 :: proc(content: string) -> int {
    re, _ := regex.create("mul\\(\\s*(\\d+)\\s*,\\s*(\\d+)\\s*\\)", flags={.Global})
    do_or_dont_mul, _ := regex.create("do\\(\\)|don't\\(\\)", flags={.Global})

    total := 0
    idx := 0
    mul_enabled := true
    for idx < len(content) {
        i, i_bool := regex.match(do_or_dont_mul, content[idx:])
        end := len(content)
        if i_bool {
            end = idx + i.pos[0][1]
        }

        idx2 := idx
        for j in regex.match(re, content[idx2:end]) {
            if mul_enabled {
                total += strconv.atoi(j.groups[1]) * strconv.atoi(j.groups[2])
            } else {
                break
            }
            idx2 += j.pos[0][1]
        }

        if i_bool && i.groups[0] == "don't()" {
            mul_enabled = false
        } else if i_bool && i.groups[0] == "do()" {
            mul_enabled = true
        }

        idx = end
    }

    return total
}
