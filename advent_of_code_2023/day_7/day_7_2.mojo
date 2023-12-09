from algorithm.sort import sort
from quicksort import TupleVar, quickSort


fn convert_card_to_int(card: String) raises -> Int:
    if card == "A":
        return 14
    elif card == "K":
        return 13
    elif card == "Q":
        return 12
    elif card == "J":  # joker
        return 1
    elif card == "T":
        return 10
    else:
        return atol(card)


fn get_game_type_value(first: Int, second: Int) -> Int:
    if first == 5 or second == 5:
        return 7
    elif first == 4 or second == 4:
        return 6
    elif (first == 3 and second == 2) or (first == 2 and second == 3):
        return 5
    elif first == 3 or second == 3:
        return 4
    elif first == 2 and second == 2:
        return 3
    elif first == 2 or second == 2:
        return 2
    else:
        return 1


fn main() raises:
    with open("input.txt", "r") as f:
        let file = f.read()

        var temp_str = String("")
        var ranks_bids = DynamicVector[TupleVar]()
        for i in range(len(file)):
            if file[i] != " " and file[i] != "\n":
                temp_str += file[i]

            if file[i] == " ":
                # hand
                var temp_result: FloatLiteral = 0
                var temp_game_type = DynamicVector[Int](5)
                temp_game_type.resize(5, 0)

                var power = 0
                for j in range(len(temp_str) - 1, -1, -1):
                    let temp = convert_card_to_int(temp_str[j])
                    var value_pos: FloatLiteral = temp
                    if value_pos >= 10:
                        value_pos = 9
                        value_pos += (temp % 9) * 0.1
                    temp_result += value_pos * 10**power

                    temp_game_type[j] = temp
                    power += 2

                sort(temp_game_type)

                var first = 1
                var second = 1
                var jokers = 0
                var flag = True
                for j in range(len(temp_game_type)):
                    if temp_game_type[j] == 1:
                        jokers += 1
                    elif j > 0 and temp_game_type[j] == temp_game_type[j - 1]:
                        if flag:
                            first += 1
                        else:
                            second += 1
                    elif first > 1:
                        flag = False

                if jokers == 5:
                    first = 5
                elif first > second:
                    first += jokers
                else:
                    second += jokers

                temp_result *= 10 ** get_game_type_value(first, second)

                ranks_bids.push_back(TupleVar(temp_result, 0))

                temp_str = ""

            if file[i] == "\n":
                ranks_bids[len(ranks_bids) - 1].second = atol(temp_str)
                temp_str = ""

        quickSort(ranks_bids, 0, len(ranks_bids) - 1)

        var result: Int = 0
        for i in range(len(ranks_bids) - 1, -1, -1):
            result += ranks_bids[i].second * (i + 1)

        print(result)
