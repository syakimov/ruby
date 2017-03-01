module TicTacToe
  class Board
    def initialize(a)
      @b = a
      a = a.flatten
      lines = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6],
               [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]

      @w = lines.map do |x, y, z|
             r = [a[x], a[y], a[z]].uniq
             r.first if r.count == 1 # ['x'] if x is winner
           end.compact[0]
    end

    def winner
      "Player with '#{@w}' is the winner." if @w
    end

    def winning_moves
      m = []
      return m unless @w
      (0..2).each { |r| (0..2).each { |c| m << [r, c] if @b[r][c] == @w } }
      m
    end
  end
end

# board1 = TicTacToe::Board.new([%w(x o x), %w(o x o), %w(x o x)])
# p board1.winning_moves #=> [[0, 0], [2, 0], [1, 1], [0, 2], [2, 2]]
# -----------------------------------------------------------------
# board2 = TicTacToe::Board.new([%w(x o x), %w(o x o), %w(x o x)])
# p board2.winner #=> "Player with 'x' is the winner."
