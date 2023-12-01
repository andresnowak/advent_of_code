fn check_if_number(value: String) -> String:
    if value == "one":
        return "1"
    elif value == "two":
        return "2"
    elif value == "three":
        return "3"
    elif value == "four":
        return "4"
    elif value == "five":
        return "5"
    elif value == "six":
        return "6"
    elif value == "seven":
        return "7"
    elif value == "eight":
        return "8"
    elif value == "nine":
        return "9"

    return ""


fn main() raises:
    with open("input.txt", "r") as f:
        let file = f.read()

        var first = String("")
        var second = String("")
        var result = 0

        for i in range(len(file)):
            var temp_value = String("")
            if file[i] == "\n":
                result += atol(first + second)
                first = ""
                second = ""

            if isdigit(ord(file[i])):
                temp_value = file[i]
            else:
                for j in range(3, 6):
                    if i + j > len(file):
                        break
                    let temp = check_if_number(file[i : i + j])
                    if temp != "":
                        temp_value = temp
                        break

            if first == "" and temp_value != "":
                first = temp_value
                second = temp_value
            elif temp_value != "":
                second = temp_value

        print(result)
