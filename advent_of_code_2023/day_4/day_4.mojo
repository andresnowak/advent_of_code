fn main() raises:
    with open("input.txt", "r") as f:
        let file = f.read()

        var winning_numbers_flag = True
        var start_flag = False
        var winning_numbers = DynamicVector[Int]()

        var result = 0
        var result_game = 0
        var match_flag = False
        var n_temp = String("")
        for i in range(len(file)):
            if len(n_temp) > 0 and not isdigit(ord(file[i])) and start_flag:
                let temp = atol(n_temp)
                if winning_numbers_flag:
                    winning_numbers.push_back(temp)
                else:
                    for i in range(len(winning_numbers)):
                        if winning_numbers[i] == atol(temp):
                            if not match_flag:
                                match_flag = True
                                result_game += 1
                            else:
                                result_game *= 2

            if file[i] == "\n":
                winning_numbers_flag = True
                start_flag = False
                result += result_game
                result_game = 0
                match_flag = False
                winning_numbers.clear()
            elif file[i] == ":":
                start_flag = True
            elif file[i] == "|":
                winning_numbers_flag = False
            elif isdigit(ord(file[i])):
                n_temp += file[i]

            if not isdigit(ord(file[i])):
                n_temp = ""

        print(result)
