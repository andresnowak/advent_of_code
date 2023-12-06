fn main() raises:
    with open("input.txt", "r") as f:
        let file = f.read()

        var count = 0
        var time = 0
        var distance = 0
        var n_temp = String("")
        for i in range(len(file)):
            if isdigit(ord(file[i])):
                n_temp += file[i]

            if file[i] == "\n":
                if count == 0:
                    time = atol(n_temp)
                else:
                    distance = atol(n_temp)
                count += 1
                n_temp = ""

        var result = 0
        for i in range(time + 1):
            let speed = i
            let time_rest = time - speed

            if speed * time_rest > distance:
                result += 1

        print(result)
