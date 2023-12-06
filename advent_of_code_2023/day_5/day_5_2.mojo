from math.limit import inf
from math import min


struct seedRanges(CollectionElement):
    var seed_start: Int
    var seed_range: Int

    fn __init__(inout self, seed_start: Int, seed_range: Int):
        self.seed_start = seed_start
        self.seed_range = seed_range

    fn __copyinit__(inout self, other: seedRanges):
        self.seed_start = other.seed_start
        self.seed_range = other.seed_range

    fn __moveinit__(inout self, owned other: seedRanges):
        self.seed_start = other.seed_start
        self.seed_range = other.seed_range

    fn get_end(self) -> Int:
        return self.seed_start + self.seed_range - 1

    fn __str__(self) -> String:
        return str(self.seed_start) + " " + str(self.seed_range)


fn main() raises:
    # Newline at the end of input file is required.
    with open("input.txt", "r") as f:
        let file = f.read()

        var count = 0
        var map_count = 0
        var seed_count = 0
        var n_temp = String("")
        var seed_start = 0

        var seeds = DynamicVector[seedRanges]()
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
                    if seed_count == 1:
                        seeds.push_back(seedRanges(seed_start, temp))
                        seed_count = 0
                    else:
                        seed_start = temp
                        seed_count = 1
                else:
                    maps[map_count] = temp
                    map_count += 1
                n_temp = ""

            if not isdigit(ord(file[i])):
                n_temp = ""

            if file[i] == "\n" and map_count == 3:
                map_count = 0

                let seeds_range = len(seeds)
                for j in range(seeds_range):
                    # divide ranges
                    if (
                        seeds[j].seed_start < maps[1]
                        and seeds[j].get_end() >= maps[1]
                        and seeds[j].get_end() <= maps[1] + maps[2] - 1
                    ):
                        let old_range = seeds[j].seed_range
                        seeds[j].seed_range = maps[1] - seeds[j].seed_start

                        seeds.push_back(
                            seedRanges(maps[1], old_range - seeds[j].seed_range)
                        )
                        seeds_flag.push_back(0)
                    elif (
                        seeds[j].seed_start < maps[1]
                        and seeds[j].get_end() > maps[1] + maps[2] - 1
                    ):
                        let old_range = seeds[j].seed_range
                        seeds[j].seed_range = maps[1] - seeds[j].seed_start

                        seeds.push_back(
                            seedRanges(maps[1], maps[1] + maps[2] - maps[1])
                        )
                        seeds_flag.push_back(0)

                        seeds.push_back(
                            seedRanges(
                                maps[1] + maps[2],
                                (seeds[j].seed_start + old_range - maps[1] - maps[2]),
                            )
                        )
                        seeds_flag.push_back(0)
                    elif (
                        seeds[j].seed_start >= maps[1]
                        and seeds[j].seed_start < maps[1] + maps[2] - 1
                        and seeds[j].get_end() > maps[1] + maps[2] - 1
                    ):
                        let old_range = seeds[j].seed_range
                        seeds[j].seed_range = (
                            maps[1] + maps[2] - 1 - seeds[j].seed_start
                        )

                        seeds.push_back(
                            seedRanges(
                                maps[1] + maps[2], old_range - seeds[j].seed_range
                            )
                        )
                        seeds_flag.push_back(0)

                for j in range(len(seeds)):
                    if (
                        seeds_flag[j] == 0
                        and seeds[j].seed_start >= maps[1]
                        and seeds[j].seed_start <= maps[1] + maps[2] - 1
                    ):
                        seeds[j].seed_start = maps[0] + (seeds[j].seed_start - maps[1])
                        seeds_flag[j] = 1

        var result = inf[DType.float64]()

        for i in range(len(seeds)):
            result = min(result, seeds[i].seed_start)

        print(result.to_int())
