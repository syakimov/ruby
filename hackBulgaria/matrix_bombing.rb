def bombard(row, col, m)
  bomb = m[row][col]
  damage = 0

  (-1..1).each do |row_offset|
    (-1..1).each do |col_offset|
      is_the_same_cell = row_offset.zero? && col_offset.zero?
      target = { row: row + row_offset, col: col + col_offset }

      next unless !is_the_same_cell && in_range(target[:row], target[:col], m)

      damage += calculate_damage(m[target[:row]][target[:col]], bomb)
    end
  end

  damage
end

def calculate_damage(target, bomb)
  target >= bomb ? bomb : target
end

def in_range(row, col, m)
  in_row_range = 0 <= row && row <= m.size - 1
  in_col_range = 0 <= col && col <= m[0].size - 1
  in_row_range && in_col_range
end

def matrix_bombing_plan(m)
  matrix_sum = m.flatten.reduce(:+)
  result = {}

  m.size.times do |row|
    m[0].size.times do |col|
      result[[row, col]] = matrix_sum - bombard(row, col, m)
    end
  end

  result
end

puts matrix_bombing_plan([[1, 2, 3],
                          [4, 5, 6],
                          [7, 8, 9]]) == { [0, 0] => 42,
                                           [0, 1] => 36,
                                           [0, 2] => 37,
                                           [1, 0] => 30,
                                           [1, 1] => 15,
                                           [1, 2] => 23,
                                           [2, 0] => 29,
                                           [2, 1] => 15,
                                           [2, 2] => 26 }
