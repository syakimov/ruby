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
      return @friends.select { |e| e.name == filter[:name] } if filter[:name]
      return @friends.select { |e| e.sex == filter[:sex] } if filter[:sex]
      @friends.select(&filter[:filter])
    end

    def unfriend(filter)
      @friends.reject! { |e| e.name == filter[:name] } if filter[:name]
      @friends.reject! { |e| e.sex == filter[:sex] } if filter[:sex]
      @friends.reject!(&filter[:filter]) if filter[:filter]
    end
  end
end
