import math

if __name__ == "__main__":
    with open("input.txt", "r", encoding="utf-8") as f:
        count = 0
        instructions = ""
        positions = {}
        starts = []
        for line in f:
            if count == 0:
                instructions = line[:-1]
            elif line != "\n":
                temp = line.split(" ")
                positions[temp[0]] = (temp[2][1:4], temp[3][:3])

                if temp[0][-1] == "A":
                    starts.append(temp[0])

            count += 1

        counts = [0 for i in range(len(starts))]

        for index, start in enumerate(starts):
            flag = False
            while not flag:
                for i in instructions:
                    if i == "L":
                        start = positions[start][0]
                    else:
                        start = positions[start][1]

                    counts[index] += 1

                    if start[-1] == "Z":
                        flag = True
                        break

        print(math.lcm(*counts))
