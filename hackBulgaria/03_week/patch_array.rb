class Array
  def to_hash
    each_with_object({}) do |pair, hash|
      hash[pair.first] = pair[1]
      hash
    end
  end

  def index_by
    map { |n| [yield(n), n] }.to_hash
  end

  def subarray_count(subarray)
    each_cons(subarray.length).count(subarray)
  end

  def occurences_count
    each_with_object(Hash.new(0)) do |x, hash|
      hash[x] = count(x)
      hash
    end
  end
end
