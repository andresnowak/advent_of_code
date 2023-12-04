from memory import memset


fn get_number_games(file: String) -> Int:
    var count = 0
    for i in range(len(file)):
        count += 1
        if file[i] == "\n":
            break

    return len(file) // count


fn main() raises:
    with open("input.txt", "r") as f:
        let file = f.read()

        let number_of_games = get_number_games(file)

        var winning_numbers_flag = True
        var start_flag = False
        var winning_numbers = DynamicVector[Int]()
        var games = DynamicVector[Int](number_of_games)
        games.resize(number_of_games)
        # set all values to 1
        for i in range(len(games)):
            games[i] = 1

        var result = 0
        var result_game = 0
        var card_game_number = 0
        var n_temp = String("")
        for i in range(len(file)):
            if len(n_temp) > 0 and not isdigit(ord(file[i])) and start_flag:
                let temp = atol(n_temp)
                if winning_numbers_flag:
                    winning_numbers.push_back(temp)
                else:
                    for i in range(len(winning_numbers)):
                        if winning_numbers[i] == atol(temp):
                            result_game += 1

            if file[i] == "\n":
                for i in range(1, result_game + 1):
                    if i + card_game_number < len(games):
                        games[i + card_game_number] += games[card_game_number]

                result += games[card_game_number]
                card_game_number += 1
                winning_numbers_flag = True
                start_flag = False
                result_game = 0
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
