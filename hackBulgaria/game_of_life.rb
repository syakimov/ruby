module GameOfLife
  class Board
    include Enumerable
    attr_accessor :cells

    def initialize(*cells)
      @cells = {}
      cells.each { |e| @cells[e] = true }
    end

    def [](*key)
      cells[key] == true
    end

    def each(&block)
      alive = cells.select { |_key, val| val }
      alive.keys.each(&block)
    end

    def count
      cells.select { |_key, val| val }.size
    end

    def population(location)
      count = 0

      (-1..1).each do |x_offset|
        (-1..1).each do |y_offset|
          new_location = [location.first + x_offset, location.last + y_offset]
          count += 1 if new_location != location && cells[new_location]
        end
      end

      count
    end

    def should_live(location)
      population(location) == 3 || (cells[location] && population(location) == 2)
    end

    def next_generation
      future = {}

      minx, maxx = cells.keys.map { |e| e.first }.minmax
      miny, maxy = cells.keys.map { |e| e.last }.minmax

      (minx - 1..maxx + 1).each do |x|
        (miny - 1..maxy + 1).each do |y|
          location = [x, y]
          future[location] = true if should_live(location)
        end
      end

      GameOfLife::Board.new(*future.keys)
    end
  end
end
