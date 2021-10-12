require_relative 'colorize'

module TextContent
  include Colorize

  def error(string)
    red(string)
  end

  def introduction
    intro = <<~MSG
      This is a Connect Four game.
      Rules:
        * You can specilize your name and symbol at the start of the game
        * When you can connect four pieces vertically, horizontally or diagonally you win
        * When the every cell of the board is filled, it is a tie
    MSG
    green(intro)
  end

  def user_input_error(available_columns)
    "Input error. Please enter a number amongs #{available_columns}"
  end

  module_function :user_input_error
end
