require_relative 'colorize'

module TextContent
  def green(string)
    "\e[32;1m#{string}\e[0m"
  end

  def red(string)
    "\e[31;1m#{string}\e[0m"
  end

  def introduction
    intro = <<~MSG
      This is a Connect Four game. The board has 7 rows and 6 columns
      Rules:
        * Players can specilize their names and markers at the start of the game
        * When a player can connect four pieces vertically, horizontally or diagonally he win
        * When the every cell of the board is filled, it is a tie
    MSG
    green(intro)
  end

  def warning_message(message)
    {
      'empty_marker_error' => red('You have to put something!!'),
      'column_error' => red('Input error. Please enter a number among available columns'),
      'duplicate_error' => red('This character has been used. Please choose a different one'),
      'long_marker_error' => red('Marker only contained 1 character. Please choose a different one')
    }[message]
  end

  module_function :warning_message, :red, :green
end
