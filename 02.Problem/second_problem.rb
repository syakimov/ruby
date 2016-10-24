class Hash
  # this does not work for nested arrays
  def fetch_deep!(roat)
    keys = roat.split '.'
    if keys.length == 1
      # recursion bottom
      self[keys[0].to_sym]
    else
      key = self[keys[0]] ? keys.shift : keys.shift.to_sym
      self[key].fetch_deep! keys.join '.'
    end
  end

  def extract_value(collection, key)
    if collection.is_a?(Hash)
      collection[key] ? collection[key] : collection[key.to_sym]
    else
      collection[key.to_i]
    end
  end

  def fetch_deep(path)
    keys = path.split '.'
    key = keys.shift

    new_collecton = extract_value(self, key)

    until keys.empty?
      key = keys.shift
      new_collecton = extract_value(new_collecton, key)
    end

    new_collecton
  end

  def reshape(shape)
    shape.each do |key, value|
      if !value.is_a?(Hash)
        # recursion bottom hits when shape is a single lvl hash
        shape[key] = fetch_deep(value)
      else
        reshape(value)
      end
    end
  end
end

class Array
  #will work for single lvl shape
  def reshape(shape)
    reshaped = []
    each do |map|
      to_be_added = shape.clone
      shape.each { |key, value| to_be_added[key] = map.fetch_deep(value) }
      reshaped << to_be_added
    end
    reshaped
  end
end
