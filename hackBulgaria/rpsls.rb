class RockPaperScissors
  attr_accessor :type
  def initialize(type)
    @type = type

    @rules = {}
    @rules[:scissors] = [:paper, :lizard]
    @rules[:paper] = [:rock, :spock]
    @rules[:rock] = [:scissors, :lizard]
    @rules[:lizard] = [:spock, :paper]
    @rules[:spock] = [:scissors, :rock]
  end

  def ==(other)
    type == other.type
  end

  def <(other)
    @rules[other.type].include? type
  end

  def <=(other)
    @rules[other.type].include?(type) || type == other.type
  end

  def >(other)
    @rules[type].include? other.type
  end

  def >=(other)
    @rules[type].include?(other.type) || type == other.type
  end
end
