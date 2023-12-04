from tensor import Tensor

# for this problem we assume numbers can't be repeated. We don't check if we have used the same number (a number in a position) twice


fn check_row_column_size(file: String) -> (Int, Int):
    var count = 0

    for i in range(len(file)):
        if file[i] == "\n":
            count = i + 1
            break

    return (len(file) // count, count)


fn check_if_number_around(
    numbers: Tensor[DType.int32], x: Int, y: Int
) -> StaticIntTuple[2]:
    var values = StaticIntTuple[2](0, 0)
    var count = 0
    for i in range(-1, 2):
        var flag = False
        for j in range(-1, 2):
            if (
                x + i < numbers.dim(0)
                and x + i >= 0
                and y + j < numbers.dim(1)
                and y + j >= 0
            ):
                if numbers[x + i, y + j] > 0 and count > 1 and not flag:
                    return StaticIntTuple[2](0, 0)

                if numbers[x + i, y + j] > 0 and not flag:
                    values[count] = numbers[x + i, y + j].to_int()
                    count += 1
                    flag = True
                if numbers[x + i, y + j] == 0:
                    flag = False

    return values


fn main() raises:
    with open("input.txt", "r") as f:
        let file = f.read()

        let rows_cols = check_row_column_size(file)

        var numbers_pos = Tensor[DType.int32](
            rows_cols.get[0, Int](), rows_cols.get[1, Int]()
        )

        var n_temp = String()
        for i in range(len(file)):
            if isdigit(ord(file[i])):
                n_temp += file[i]

            if len(n_temp) > 0 and not isdigit(ord(file[i])):
                let x = i // rows_cols.get[1, Int]()
                let y = i % rows_cols.get[1, Int]()

                let temp = atol(n_temp)
                for j in range(len(n_temp)):
                    numbers_pos[VariadicList(x, y - len(n_temp) + j)] = temp
                n_temp = ""

            if not isdigit(ord(file[i])):
                n_temp = ""

        var result = 0
        for i in range(len(file)):
            if file[i] == "*":
                let x = i // rows_cols.get[1, Int]()
                let y = i % rows_cols.get[1, Int]()

                let values = check_if_number_around(numbers_pos, x, y)
                # print(values)
                result += values[0] * values[1]

        print(result)
