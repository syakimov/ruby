module TicTacToe
  class Board
    def initialize(board)
      @board = board
      @moves = []
      check_for_winning_rows(board)
      check_for_winning_cols(board)
      check_for_winning_diagonals(board)
    end

    def check_for_winning_diagonals(board)
      left = [board[0][0], board[1][1], board[2][2]].count 'x'
      @moves = [[0,0], [1, 1], [2, 2]] if left == 3 || left.zero?
      right = [board[0][2], board[1][1], board[2][0]].count 'x'
      @moves = [[0, 2], [1, 1], [2, 0]] if right == 3 || right.zero?
    end

    def check_for_winning_rows(board)
      (0..2).each do |row|
        c = board[row].count 'x'
        @moves = [[row, 0], [row, 1], [row, 2]] if c == 3 || c.zero?
      end
    end

    def check_for_winning_cols(board)
      (0..2).each do |col|
        c = [board[0][col], board[1][col], board[2][col]].count 'x'
        @moves = [[0, col], [1, col], [2, col]] if c == 3 || c.zero?
      end
    end

    def _winner
      return nil unless @moves.first
      row = @moves.first.first
      col = @moves.first.last
      @board[row][col]
    end

    def winner
      "Player with '#{_winner}' is the winner." if _winner
    end

    def winning_moves
      w = _winner
      win_moves = []
      (0..2).each do |r|
        (0..2).each do |c|
          win_moves << [r, c] if @board[r][c] == w
        end
      end

      win_moves
    end
  end
end

board = TicTacToe::Board.new([%w(o o o),
                              %w(o x o),
                              %w(x o x)])

p board.winner
p board.winning_moves
