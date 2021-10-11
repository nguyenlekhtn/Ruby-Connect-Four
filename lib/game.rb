class Game
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
    players_turn
    conclusion
  end

  def create_player(index, duplicate)
    name = player_name(index)
    marker = player_marker(index, duplicate)
    Player.new(name: name, marker: marker)
  end

  def show_board
    board.show
  end

  private

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
    introduction
    @first_player = create_player(0)
    @second_player = create_player(1, first_player.marker)
  end

  def play_turn
    available_columns = board.available_columns
    column = current_player.column_input(available_columns)
    board.make_drop_on(column)
  end

  def introduction
    <<~MSG
      This is a Connect Four game.
    MSG
  end

  
end
