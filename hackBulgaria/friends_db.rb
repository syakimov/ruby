module Friendship
  class Friend
    attr_accessor :name, :sex, :age

    def initialize(name, sex, age)
      @name = name
      @sex = sex
      @age = age
    end

    def male?
      sex == :male
    end

    def female?
      sex == :female
    end

    def over_eighteen?
      age > 18
    end

    def long_name?
      name.length > 10
    end
  end

  class Database
    include Enumerable
    def initialize
      @friends = []
    end

    def add_friend(name, sex, age)
      @friends << Friendship::Friend.new(name, sex, age)
    end

    def each(&block)
      @friends.each(&block)
    end

    def have_any_friends?
      !@friends.count.zero?
    end

    def find(filter)
      return @friends.select{ |e| e.name == filter[:name]} if filter[:name]
      return @friends.select{ |e| e.sex == filter[:sex]} if filter[:sex]
      return @friends.select{ |e| e.age == filter[:age]} if filter[:age]
      @friends.select(&filter[:filter])
    end

    def unfriend(filter)
      @friends = @friends.reject{ |e| e.name == filter[:name]} if filter[:name]
      @friends = @friends.reject{ |e| e.sex == filter[:sex]} if filter[:sex]
      @friends = @friends.reject{ |e| e.age == filter[:age]} if filter[:age]
      @friends = @friends.reject(&filter[:filter]) if filter[:filter]
    end
  end
end

friends = Friendship::Database.new
friends.add_friend('Peter', :male, 28)
friends.add_friend('Maria', :female, 25)
friends.add_friend('Denis', :male, 18)

puts friends.map(&:name) #=>  ['Peter', 'Maria', 'Denis']

friends.unfriend(name: 'Denis')
puts friends.map(&:name) #=> ['Peter', 'Maria']

puts friends.unfriend(sex: :male)
puts friends.map(&:name) #=> ['Maria']

puts friends.unfriend(filter: ->(friend) { friend.age == 25 })
puts friends.have_any_friends? #=> false
