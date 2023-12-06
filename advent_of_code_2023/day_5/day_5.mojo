from math.limit import inf
from math import min


fn main() raises:
    with open("input.txt", "r") as f:
        # Newline at the end of input file is required.
        let file = f.read()

        var count = 0
        var map_count = 0
        var n_temp = String("")
        var seeds = DynamicVector[Int]()
        var seeds_flag = DynamicVector[Int]()
        var maps = StaticIntTuple[3](
            0, 0, 0
        )  # destination range start, the source range start, and the range length.

        for i in range(len(file)):
            if file[i] == ":":
                if count == 1:
                    seeds_flag.resize(len(seeds), 0)
                count += 1

                for j in range(len(seeds_flag)):
                    seeds_flag[j] = 0

            if isdigit(ord(file[i])):
                n_temp += file[i]

            if len(n_temp) > 0 and not isdigit(ord(file[i])):
                let temp = atol(n_temp)

                if count == 1:
                    seeds.push_back(temp)
                else:
                    maps[map_count] = temp
                    map_count += 1
                n_temp = ""

            if not isdigit(ord(file[i])):
                n_temp = ""

            if file[i] == "\n" and map_count == 3:
                map_count = 0

                for j in range(len(seeds)):
                    if (
                        seeds_flag[j] == 0
                        and seeds[j] >= maps[1]
                        and seeds[j] <= maps[1] + maps[2] - 1
                    ):
                        seeds[j] = maps[0] + (seeds[j] - maps[1])
                        seeds_flag[j] = 1

        var result = inf[DType.float64]()
        for i in range(len(seeds)):
            result = min(result, seeds[i])

        print(result.to_int())
