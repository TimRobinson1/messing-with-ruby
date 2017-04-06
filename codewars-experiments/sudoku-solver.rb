# Very interesting kata involving solving a mostly completed sudoku - beta.

DIGITS = [1, 2, 3, 4, 5, 6, 7, 8, 9]

def sudokuer(puzzle)
  solution = puzzle
  transposed = puzzle.transpose

  row_posibilities = Array.new(9, [])
  col_posibilities = Array.new(9, [])

  9.times do |i|
    row_posibilities[i] = (DIGITS - puzzle[i] - [0])
    col_posibilities[i] = (DIGITS - transposed[i] - [0])
  end

  while(solution.flatten.uniq.include? 0)
    9.times do |i|
      9.times do |j|
        next if solution[i][j] != 0

        common_possibilities = row_posibilities[i] & col_posibilities[j]
        if common_possibilities.size == 1
          solution[i][j] = common_possibilities.first

          row_posibilities[i] -= common_possibilities
          col_posibilities[j] -= common_possibilities
        end
      end
    end
  end

  solution
end
