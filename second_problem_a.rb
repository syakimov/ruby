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
      if value.is_a?(Hash)
        # TODO: Go recursively
      else
        shape[key] = fetch_deep(value)
      end
    end
    shape
  end
end
