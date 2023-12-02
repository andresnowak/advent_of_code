fn main() raises:
    let red = 12
    let green = 13
    let blue = 14

    with open("input.txt", "r") as f:
        let file = f.read()

        var games = 0
        var games_temp = 0
        var flag = True

        var n_temp = String("")
        for i in range(len(file)):
            if file[i] == "\n":
                if flag:
                    games += games_temp
                flag = True
                n_temp = ""
                games_temp = 0

            if isdigit(ord(file[i])):
                n_temp += file[i]

            if file[i] == ":":
                games_temp = atol(n_temp)
                n_temp = ""

            if file[i] == "g" and flag and n_temp != "":
                if atol(n_temp) > green:
                    flag = False
                n_temp = ""

            if file[i] == "r" and flag and n_temp != "":
                if atol(n_temp) > red:
                    flag = False
                n_temp = ""

            if file[i] == "b" and flag and n_temp != "":
                if atol(n_temp) > blue:
                    flag = False
                n_temp = ""

        print(games)
