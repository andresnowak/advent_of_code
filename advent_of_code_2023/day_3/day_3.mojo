from tensor import Tensor


fn check_row_column_size(file: String) -> (Int, Int):
    var count = 0

    for i in range(len(file)):
        if file[i] == "\n":
            count = i + 1
            break

    return (len(file) // count, count)


fn check_if_symbol_around(symbols: Tensor[DType.int8], x: Int, y: Int) -> Bool:
    for i in range(-1, 2):
        for j in range(-1, 2):
            if (
                x + i < symbols.dim(0)
                and x + i >= 0
                and y + j < symbols.dim(1)
                and y + j >= 0
                and symbols[x + i, y + j] == 1
            ):
                return True

    return False


fn main() raises:
    with open("input.txt", "r") as f:
        let file = f.read()

        let rows_cols = check_row_column_size(file)

        var symbol_pos = Tensor[DType.int8](
            rows_cols.get[0, Int](), rows_cols.get[1, Int]()
        )

        for i in range(len(file)):
            if file[i] != "." and file[i] != "\n" and not isdigit(ord(file[i])):
                let x = i // rows_cols.get[1, Int]()
                let y = i % rows_cols.get[1, Int]()

                symbol_pos[VariadicList(x, y)] = 1

        var result = 0
        var n_temp = String()

        for i in range(len(file)):
            if isdigit(ord(file[i])):
                n_temp += file[i]

            if len(n_temp) > 0 and not isdigit(ord(file[i])):
                let temp = atol(n_temp)

                var flag = False
                for j in range(len(n_temp)):
                    let x = i // rows_cols.get[1, Int]()
                    let y = i % rows_cols.get[1, Int]()

                    if not flag and check_if_symbol_around(
                        symbol_pos, x, y - len(n_temp) + j
                    ):
                        flag = True

                if flag:
                    result += temp
                n_temp = ""

            if not isdigit(ord(file[i])):
                n_temp = ""

        print(result)
