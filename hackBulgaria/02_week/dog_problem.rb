class Dog
  def initialize(name, owner, is_biting, dog_years)
    @name = name
    @owner = owner
    @is_biting = is_biting
    @dog_years = dog_years
  end

  attr_reader :name
  attr_writer :name

  attr_reader :owner
  attr_writer :owner

  attr_reader :dog_years
  attr_writer :dog_years

  def to_human_years
    @dog_years / 7
  end

  def bites?
    @is_biting
  end

  def bark
    'Bark! Bark!'
  end

  def bark!
    @is_biting = true
    'Bark! Bark!'
  end

  def ==(other)
    @name == other.name && @owner == other.owner &&
      @dog_years == other.dog_years
  end

  def same_owner?(dog)
    @owner == dog.owner
  end
end
