def number_to_digits(n)
  n.to_s.split('').map(&:to_i)
end

def digits_to_number(arr)
  arr.map(&:to_s).reduce(:+).to_i
end

def grayscale_histogram(image)
  arr = (0..255).map { 0 }.to_a
  image.flatten.each { |x| arr[x] += 1 }
  arr
end

def sum_matrix(m)
  m.flatten.reduce(:+)
end

def max_scalar_product(v1, v2)
  sorted1 = v1.sort
  sorted2 = v2.sort
  (0..(v1.size - 1)).map { |i| sorted1[i] * sorted2[i] }.reduce(:+)
end

def max_span(numbers)
  unique = numbers.uniq
  reversed_numbers = numbers.reverse
  spans = []

  unique.each do |num|
    first_index = numbers.find_index(num)
    last_index = numbers.count - reversed_numbers.find_index(num)
    span = last_index - first_index

    spans.push span
  end

  spans.max
end

def _bombard(row, col, m)
  bomb = m[row][col]
  damage = 0

  (-1..1).each do |row_offset|
    (-1..1).each do |col_offset|
      is_the_same_cell = row_offset.zero? && col_offset.zero?
      target = { row: row + row_offset, col: col + col_offset }

      next unless !is_the_same_cell && _in_range(target[:row], target[:col], m)

      damage += _calculate_damage(m[target[:row]][target[:col]], bomb)
    end
  end

  damage
end

def _calculate_damage(target, bomb)
  target >= bomb ? bomb : target
end

def _in_range(row, col, m)
  in_row_range = 0 <= row && row <= m.size - 1
  in_col_range = 0 <= col && col <= m[0].size - 1
  in_row_range && in_col_range
end

def matrix_bombing_plan(m)
  matrix_sum = m.flatten.reduce(:+)
  result = {}

  m.size.times do |row|
    m[0].size.times do |col|
      result[[row, col]] = matrix_sum - _bombard(row, col, m)
    end
  end

  result
end

def max_consecutive(items)
  max = curr_max = 0

  (0..items.size - 2).each do |i|
    current = items[i]
    following = items[i + 1]

    if current == following
      curr_max = curr_max.zero? ? 2 : curr_max + 1
    else
      max = curr_max if curr_max > max
      curr_max = 0
    end
  end

  max > curr_max ? max : curr_max
end

def group(items)
  return 'edge case' if items.count <= 2
  main_arr = []

  i = 0
  while i < items.size
    sequence = _count_equal_consecutive_elements(items, i)
    main_arr.push(Array.new(sequence, items[i]))
    i += sequence
  end

  main_arr
end

def _count_equal_consecutive_elements(items, i)
  size = items.size
  last_index = size - 1
  before_last_index = size - 2 # предпоследен

  return 0 if size.zero? || i >= size
  return 1 if i == last_index
  if i == before_last_index
    return (items[before_last_index] == items[last_index] ? 2 : 1)
  end

  arr = items.slice(i, items.size)
  _count_equal_elements_from_the_beginning(arr)
end

def _count_equal_elements_from_the_beginning(arr)
  count = 1
  i = 0
  while arr[i] == arr[i + 1]
    count += 1
    i += 1
  end

  count
end
