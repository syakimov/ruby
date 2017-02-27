class Podcast
  attr_accessor :name
  def initialize(name)
    @name = name
    @epizodes = []
    @count = 1
  end

  def <<(epizode)
    epizode.id = @count
    @count += 1
    @epizodes << epizode
  end

  def find(filter)
    if filter[:name]
      return @epizodes.select do |e|
        e.name.downcase.include?(filter[:name].downcase)
      end
    end

    @epizodes.select do |e|
      is_valid = true
      filter[:description].each do |f|
        is_valid = false unless e.description.downcase.include?(f.downcase)
      end

      is_valid
    end
  end

  def info
    output = ''
    output += "Podcast: #{name}\n"
    output += "Total episodes: #{@epizodes.size}\n"
    output += "Total duration: #{@epizodes.map{|e| e.minutes}.reduce(:+)}\n"

    @epizodes.each do |e|
      output += '=========='
      output += "\n"
      output += "Episode #{e.id}\n"
      output += "Name: #{e.name}\n"
      output += e.description
      output += "\n"
      output += "Duration: #{e.minutes} minutes"
      output += "\n"
    end

    p output
  end
end

class Episode
  attr_accessor :id, :name, :description, :minutes
  def initialize(name, description, minutes)
    @name = name
    @description = description
    @minutes = minutes
  end
end
