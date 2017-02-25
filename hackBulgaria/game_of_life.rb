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
      cells_arr = []
      cells.each { |cell| cells_arr << cell }

      cells_arr.each(&block)
    end

    def count
      c = 0
      cells.each { |_key, val| c += 1 if val }
      c
    end
  end
end

board = GameOfLife::Board.new [1, 2], [1, 3], [5, 6]

board[1, 2] # true
board[0, 2] # false

board.each do |x, y|
  puts "The cell at (#{x}, #{y}) is alive"
end
