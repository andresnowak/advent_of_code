from math import max


fn main() raises:
    var red = 0
    var blue = 0
    var green = 0

    with open("input.txt", "r") as f:
        let file = f.read()

        var games = 0
        var flag = True

        var n_temp = String("")
        for i in range(len(file)):
            if file[i] == "\n":
                games += red * blue * green
                flag = True
                n_temp = ""
                red = 0
                blue = 0
                green = 0

            if isdigit(ord(file[i])):
                n_temp += file[i]

            if file[i] == ":":
                n_temp = ""

            if file[i] == "g" and flag and n_temp != "":
                green = max(green, atol(n_temp))
                n_temp = ""

            if file[i] == "r" and flag and n_temp != "":
                red = max(red, atol(n_temp))
                n_temp = ""

            if file[i] == "b" and flag and n_temp != "":
                blue = max(blue, atol(n_temp))
                n_temp = ""

        print(games)
