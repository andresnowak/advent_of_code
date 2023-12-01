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

            if first == "" and temp_value != "":
                first = temp_value
                second = temp_value
            elif temp_value != "":
                second = temp_value

        print(result)
