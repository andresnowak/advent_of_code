
fn part_1(input: String) -> Int:
    # Find XMAS

    # Get row size
    var row_size = 0
    for i in input:
        row_size += 1
        if i == "\n":
            break

    var count = 0

    var size_xmas = 4 # XMAS
    for i in range(len(input)):
        # Check horizontally
        if i + size_xmas < len(input):
            var tmp = input[i: i + size_xmas]

            if tmp == "XMAS":
                count += 1
            if tmp[::-1] == "XMAS":
                count += 1

        # Check vertically
        if i + row_size * 3 < len(input):
            var tmp: String = ""

            for j in range(size_xmas):
                tmp += input[i + j * row_size]

            if tmp == "XMAS":
                count += 1
            if tmp[::-1] == "XMAS":
                count += 1
        
        # Check diagonally
        # Check diagonally right
        if i + row_size * 3 + 3 < len(input):
            var tmp: String = ""

            for j in range(size_xmas):
                tmp += input[i + j * row_size + j]

            if tmp == "XMAS":
                count += 1
            if tmp[::-1] == "XMAS":
                count += 1
        
        # Check diagonally left
        if i - row_size * 3 - 3 >= 0:
            var tmp: String = ""

            for j in range(size_xmas):
                tmp += input[i - j * row_size - j]

            if tmp == "XMAS":
                count += 1
            if tmp[::-1] == "XMAS":
                count += 1    

    return count


fn part_2(input: String) -> Int:
    # Find X-MAS

    # Get row size
    var row_size = 0
    for i in input:
        row_size += 1
        if i == "\n":
            break
    
    var count = 0

    var size_xmas = 3 # MAS
    for i in range(len(input)):
        # Check diagonally right
        var x_count = 0

        var tmp: String = ""
        for j in range(-1, 2):
            if i + j * row_size + j < len(input) and i + j * row_size + j >= 0:
                tmp += input[i + j * row_size + j]
        
        if tmp == "MAS":
            x_count += 1
        elif tmp[::-1] == "MAS":
            x_count += 1
        
        # Check diagonally left
        tmp = ""
        for j in range(-1, 2):
            if i + j * row_size - j < len(input) and i + j * row_size - j >= 0:
                tmp += input[i + j * row_size - j]
        
        if tmp == "MAS":
            x_count += 1
        elif tmp[::-1] == "MAS":
            x_count += 1

        if x_count == 2:
            count += 1

    return count


fn main() raises:
    with open("day_4_input.txt", "r") as f:
        var input = f.read()

        var result = part_1(input)
        print(result)

        result = part_2(input)
        print(result)
