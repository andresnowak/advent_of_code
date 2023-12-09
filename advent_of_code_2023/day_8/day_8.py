if __name__ == "__main__":
    with open("input.txt", "r", encoding="utf-8") as f:
        count = 0
        instructions = ""
        positions = {}
        start = ""
        for line in f:
            if count == 0:
                instructions = line[:-1]
            elif line != "\n":
                temp = line.split(" ")
                positions[temp[0]] = (temp[2][1:4], temp[3][:3])

            count += 1

        count = 0

        start = "AAA"
        while start != "ZZZ":
            for i in instructions:
                count += 1
                if i == "L":
                    start = positions[start][0]
                elif i == "R":
                    start = positions[start][1]

                if start == "ZZZ":
                    break

        print(count)
