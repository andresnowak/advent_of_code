fn main() raises:
    with open("input.txt", "r") as f:
        let file = f.read()

        var count = 0
        var times = DynamicVector[Int]()
        var distance = DynamicVector[Int]()
        var n_temp = String("")
        for i in range(len(file)):
            if isdigit(ord(file[i])):
                n_temp += file[i]

            if len(n_temp) > 0 and not isdigit(ord(file[i])):
                if count == 0:
                    times.push_back(atol(n_temp))
                else:
                    distance.push_back(atol(n_temp))
                n_temp = ""

            if file[i] == "\n":
                count += 1

        var result = 1
        for i in range(len(times)):
            var record = 0
            for j in range(times[i] + 1):
                let speed = j
                let time = times[i] - speed
                if speed * time > distance[i]:
                    record += 1

            result *= record

        print(result)
