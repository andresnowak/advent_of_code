import fileinput


def check_won(board):
    row = len(board)

    for i in range(row):
        rows = 0
        cols = 0
        for j in range(row):
            if board[i][j] == 0:
                rows += 1
            if board[j][i] == 0:
                cols += 1

        if rows == 5 or cols == 5:
            return True

    return False


def check_if_exists(pos, boards, value):
    count = 0
    row = len(boards[pos])

    for i in range(row):
        for j in range(row):
            if boards[pos][i][j] == value:
                boards[pos][i][j] = 0
                count += 1

    won = check_won(boards[pos])

    return [won, count * value]


def main():
    values = [int(i) for i in input().split(",")]
    boards = []
    sum_of_boards = []

    sum_board = 0
    board = []

    # ctrl + d for EOF, to finish the for
    for line in fileinput.input():
        line_board = [int(i) for i in line.split(" ") if i != "\n" and i != ""]

        if line_board != []:
            sum_board += sum(line_board)
            board.append(line_board)

        if len(line_board) == 0 and len(board) != 0:
            boards.append(board)
            sum_of_boards.append(sum(map(sum, board)))
            board = []
            sum_board = 0

    boards.append(board)
    sum_of_boards.append(sum_board)

    print(boards)

    for i in range(len(values)):
        for j in range(len(boards)):
            won, result = check_if_exists(j, boards, values[i])

            sum_of_boards[j] -= result
            print(sum_of_boards)

            if won:
                print(f"result {sum_of_boards[j] * values[i]}")
                return

    print("end")


if __name__ == "__main__":
    main()
