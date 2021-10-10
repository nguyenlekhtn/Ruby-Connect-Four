require_relative 'board'

class Player
  attr_reader :board, :marker

  def initialize(marker:, board:)
    @board = board
    @marker = marker
  end

  def play_turn
    loop do
      column = column_input
      dropped_column = drop(column)

      break if dropped_column
    end
  end

  def drop(column)
    board.drop(column: column, marker: marker)
  end
end

