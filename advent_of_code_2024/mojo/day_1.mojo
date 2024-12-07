from collections import Dict


fn part_2(input: String) raises -> Int:
    var left_size = List[Int]()
    var right_size = List[Int]()

    read_values(left_size, right_size, input)

    var dicta = Dict[Int, Int]()

    for i in right_size:
        if i[] not in dicta:
            dicta[i[]] = 0
        dicta[i[]] += 1

    var result = 0

    for i in left_size:
        if i[] in dicta:
            result += i[] * dicta[i[]]

    return result


fn part_1(input: String) raises -> Int:
    var left_size = List[Int]()
    var right_size = List[Int]()

    read_values(left_size, right_size, input)

    sort(left_size)
    sort(right_size)

    result = 0
    for i in range(len(left_size)):
        result += abs(left_size[i] - right_size[i])

    return result


fn read_values(
    mut left_size: List[Int], mut right_size: List[Int], input: String
) raises:
    var start = 0
    var end = 0

    for i in range(len(input)):
        if input[i] != "\n" and input[i] != " ":
            end += 1
        else:
            if input[i] == "\n" and start != end:
                right_size.append(int(input[start:end]))
            elif start != end:
                left_size.append(int(input[start:end]))

            end += 1
            start = end

    right_size.append(int(input[start:end]))


fn main() raises:
    var input: String = ""
    with open("day_1_input.txt", "r") as f:
        input = f.read()

    result = part_1(input)
    print(result)

    result = part_2(input)
    print(result)
