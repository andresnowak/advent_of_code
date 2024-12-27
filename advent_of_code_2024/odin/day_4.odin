package main

import "core:fmt"
import "core:os"
import "core:strconv"
import "core:strings"
import "core:unicode/utf8"

main :: proc() {
    input, _ := os.read_entire_file("day_4_input.txt")
    defer delete(input)

    result := part_1(string(input))
    fmt.println(result)

    result = part_2(string(input))
    fmt.println(result)
}


part_1 :: proc(content: string) -> int {
    // Find XMAS words
    // Check size of the first row
    row_size := 0
    for i in content {
        row_size += 1
        if i == '\n' {
            break
        }
    }

    size := 4 // XMAS

    count := 0

    tmp_string: [4]u8
    for i in 0 ..< len(content) {
        // check horizontally
        if i + size < len(content) && content[i:i + size] == "XMAS" {
            count += 1
        }
        // check backward
        if i + size < len(content) && strings.reverse(content[i:i + size]) == "XMAS" {
            count += 1
        }
        // check vertically
        if i + row_size * 3 < len(content) {
            // Copy the 4 vertical characters to the tmp string
            for j in 0 ..< 4 {
                tmp_string[j] = content[i + j * row_size]
            }
            tmp := strings.clone_from_bytes(tmp_string[:])
            // tmp := strings.join({content[i: i + 1], content[i + row_size: i + row_size + 1], content[i + row_size * 2: i + row_size * 2 + 1], content[i + row_size * 3: i + row_size * 3 + 1]}, "")
            if tmp == "XMAS" {
                count += 1
            }
            if strings.reverse(tmp) == "XMAS" {
                count += 1
            }
        }
        // check diagonally
        // check diagonally right
        if i + row_size * 3 + 3 < len(content) {
            for j in 0 ..< 4 {
                tmp_string[j] = content[i + j * row_size + j]
            }
            tmp := strings.clone_from_bytes(tmp_string[:])
            // tmp := strings.join({content[i: i + 1], content[i + row_size + 1: i + row_size + 2], content[i + row_size * 2 + 2: i + row_size * 2 + 3], content[i + row_size * 3 + 3: i + row_size * 3 + 4]}, "")
            if tmp == "XMAS" {
                count += 1
            }
            if strings.reverse(tmp) == "XMAS" {
                count += 1
            }
        }
        // check diagonally left
        if i - row_size * 3 - 3 >= 0 {
            for j in 0 ..< 4 {
                tmp_string[j] = content[i - j * row_size - j]
            }
            tmp := strings.clone_from_bytes(tmp_string[:])

            // tmp := strings.join({content[i: i + 1], content[i - row_size - 1: i - row_size], content[i - row_size * 2 - 2: i - row_size * 2 - 1], content[i - row_size * 3 - 3: i - row_size * 3 - 2]}, "")
            if tmp == "XMAS" {
                count += 1
            }
            if strings.reverse(tmp) == "XMAS" {
                count += 1
            }
        }
    }

    return count
}


part_2 :: proc(content: string) -> int {
    // Find X-MAS
    // Check size of the first row
    row_size := 0
    for i in content {
        row_size += 1
        if i == '\n' {
            break
        }
    }

    size := 3 // X-MAS

    count := 0

    tmp_string: [3]u8

    for i in 0 ..< len(content) {
        // Check for X-MAS
        // check diagonally right
        x_count := 0

        for j in -1 ..< 2 {
            if i + j * row_size + j >= 0 && i + j * row_size + j < len(content) {
                tmp_string[j + 1] = content[i + j * row_size + j]
            } else {
                tmp_string[j + 1] = 10
            }
        }
        tmp := strings.clone_from_bytes(tmp_string[:])

        if tmp == "MAS" {
            x_count += 1
        } else if strings.reverse(tmp) == "MAS" {
            x_count += 1
        }

        // check diagonally left
        for j in -1 ..< 2 {
            if i + j * row_size - j >= 0 && i + j * row_size - j < len(content) {
                tmp_string[j + 1] = content[i + j * row_size - j]
            } else {
                tmp_string[j + 1] = 8
            }
        }
        tmp = strings.clone_from_bytes(tmp_string[:])

        if tmp == "MAS" {
            x_count += 1
        } else if strings.reverse(tmp) == "MAS" {
            x_count += 1
        }

        // Check there was X-MAS
        if x_count == 2 {
            count += 1
        }
    }

    return count
}




read_content :: proc(content: string, values: ^[dynamic]string) {
    start := 0
    end := 0
    for end < len(content) {
        if content[end] == '\n' {
            append(values, content[start:end]) // why do append(&(values^), content[start:end]) ?
            start = end + 1
        }

        end += 1
    }
}
