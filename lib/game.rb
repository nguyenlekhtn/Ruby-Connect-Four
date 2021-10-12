require_relative 'board'
require_relative 'player'
require_relative 'text_content'

class Game
  include TextContent

  attr_reader :board, :first_player, :second_player, :current_player

  def initialize(board: Board.new, first_player: nil, second_player: nil, current_player: nil)
    @board = board
    @first_player = first_player
    @second_player = second_player
    @current_player = current_player
  end

  def play
    game_setup
    show_board
    turns
    conclusion
  end

  def create_player(index:, duplicate: nil)
    name = player_name(index)
    marker = player_marker(index, duplicate)
    Player.new(name: name, marker: marker)
  end

  def turn
    puts "#{current_player_name}'s turn"
    column_input = current_player.column_input(board_available_columns)
    board_drop_on_column(column_input)
    show_board
  end

  def board_drop_on_column(column)
    board.drop(column: column, marker: current_player_marker)
  end

  def show_board
    board.show
  end

  def board_available_columns
    board.available_columns
  end

  def board_full?
    board.full?
  end

  def winner?
    board.any_same_four_in_line?
  end

  def current_player_name
    current_player.name
  end

  def current_player_marker
    current_player.marker
  end

  private

  def conclusion
    if winner?
      annouce_winner(current_player_name)
    else
      annouce_tie
    end
  end

  def switch_current_player
    @current_player = current_player == first_player ? second_player : first_player
  end

  def turns
    until board_full?
      turn
      break if winner?

      switch_current_player
    end
  end

  def marker_input(duplicate)
    loop do
      input = gets.chomp
      return input if input != duplicate

      puts 'This character has been used. Please choose a different one'
    end
  end

  def player_name(index)
    print "Enter player #{index}'s name: "
    gets.chomp
  end

  def player_marker(index, duplicate = nil)
    print "Enter player #{index}'s marker: "
    marker_input(duplicate)
  end

  def game_setup
    puts introduction
    @first_player = create_player(index: 0)
    @second_player = create_player(index: 1, duplicate: first_player.marker)
    @current_player = first_player
  end

  # def play_turn
  #   available_columns = board.available_columns
  #   column = current_player.column_input(available_columns)
  #   board.make_drop_on(column)
  # end

  def annouce_winner(name)
    puts "#{name} won. Congratulations ^.^"
  end

  def annouce_tie
    puts 'No one won. Touch match right?'
  end
end
