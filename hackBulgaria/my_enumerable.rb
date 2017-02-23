# rubocop disable Style/Documentation
# rubocop disable Metrics/ModuleLength
module MyEnumerable
  def map
    arr = []
    each { |e| arr << yield(e) }
    arr
  end

  def filter
    arr = []
    each { |e| arr.push e unless yield(e) }
    arr
  end

  def reject
    arr = []
    each { |e| arr.push e unless yield(e) }
    arr
  end

  def reduce(initial = nil)
    result = initial

    each do |e|
      result = yield(result, e)
    end
    result
  end

  def any?
    result = false
    each { |e| result = true if yield(e) }
    result
  end

  def one?
    count = 0
    each { |e| count += 1 if yield(e) }
    count == 1
  end

  def all?
    result = true
    each { |e| result = false unless yield(e) }
    result
  end

  # def each_cons(n)
  #   original = []
  #   each { |e| original.push(e) }
  #
  #   inner_arr_count = original.size - n
  #   main = []
  #   (0..inner_arr_count).each do |i|
  #     temp = original.drop(i).take(n)
  #     main << temp
  #   end
  #
  #   main
  # end

  def each_cons(n)
    original = []
    index = 0
    each { |el| original << el }
    while index <= size - n
      yield original[index...(index + n)]
      index += 1
    end
    original
  end

  def include?(element)
    result = false
    each { |e| result = true if e == element }
    result
  end

  # Count the occurences of an element in the collection. If no element is
  # given, count the size of the collection.
  def count(element = nil)
    return size unless element
    count = 0
    each { |e| count += 1 if element == e }
    count
  end

  # Count the size of the collection.
  def size
    length = 0
    each { |_e| length += 1 }
    length
  end

  # Groups the collection by result of the block.
  # Returns a hash where the keys are the evaluated
  # result from the block and the values are arrays
  # of elements in the collection that correspond to
  # the key.
  def group_by
  end

  def min
    curr = 99_999_999_999_999_999_999
    each { |e| curr = e if curr > e }
    curr
  end

  def min_by
    arr = map { |e| [yield(e), e] }
    z = arr.reduce { |acc, elem| acc.first < elem.first ? acc : elem }
    z.last
  end

  def max
    curr = -99_999_999_999_999_999_999
    each { |e| curr = e if curr < e }
    curr
  end

  def max_by
    arr = map { |e| [yield(e), e] }
    z = arr.reduce { |acc, elem| acc.first > elem.first ? acc : elem }
    z.last
  end

  def minmax
    x = min
    y = max
    [x, y]
  end

  def minmax_by
    arr = map { |e| [yield(e), e] }
    min_tupple = arr.reduce { |acc, elem| acc.first < elem.first ? acc : elem }
    max_tupple = arr.reduce { |acc, elem| acc.first > elem.first ? acc : elem }
    [min_tupple.last, max_tupple.last]
  end

  def take(n)
    arr = []
    count = 0
    each do |e|
      if count < n
        arr.push(e)
        count += 1
      end
    end
    arr
  end

  def take_while
    push = true
    arr = []
    each do |e|
      push = false unless yield(e)
      arr.push(e) if push
    end
    arr
  end

  def drop(n)
    arr = []
    count = 0

    each do |e|
      arr.push(e) if count >= n
      count += 1
    end
    arr
  end

  def drop_while
    push = false
    arr = []
    each do |e|
      push = true unless yield(e)
      arr.push(e) if push
    end
    arr
  end
end
