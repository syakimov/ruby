require 'set'

def balance_two_arrays(arr_one, arr_two)
  sum1 = arr_two.reduce(0, :+)
  sum2 = arr_one.reduce(0, :+)
  diff = sum1 - sum2
  if diff < 0
    arr_one, arr_two = arr_two, arr_one
    diff = diff.abs
  end
  set_two = Set.new(arr_two)

  arr_one.each_with_object([]) do |e, result|
    wanted_element = e + diff / 2
    result << [e, wanted_element] if set_two.include? wanted_element
  end
end

p balance_two_arrays([4, 3, 5, -1], [3, 6, 4, 2])[0].join(', ') # [4, 6]
p balance_two_arrays([4, 3, 4], [5, 10])[0].join(', ')          # [3, 5]
p balance_two_arrays([5, 10], [4, 3, 4])[0].join(', ')          # [5, 3]
p balance_two_arrays([-1, 3, 9], [14, 1])[0].join(', ')         # [-1, 1]
p balance_two_arrays([14, 1], [-1, 3, 9])[0].join(', ')         # [1, -1]

# tests = [[4, 3, 5, -1], [3, 6, 4, 2],
#          [4, 3, 4], [5, 10],
#          [5, 10], [4, 3, 4],
#          [-1, 3, 9], [14, 1],
#          [14, 1], [-1, 3, 9],
#          [-4, -3, -4], [-5, -10],
#          [-5, -10], [-4, -3, -4],
#          [4, 3, 4], [5, 11],
#          [4, 3, 4], [3, 12],
#          [], [0],
#          [0], [],
#          [], []]
