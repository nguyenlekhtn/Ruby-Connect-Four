require_relative 'board'

class Player
  attr_reader :marker

  def initialize(marker:)
    @marker = marker
  end

  def column_input(available_columns)
    loop do
      user_input = gets.chomp
      verified_input = verified_input(available_columns, user_input.to_i) if user_input.match(/^\d+$/)
      return verified_input if verified_input

      puts "Input error. Please enter a number amongs #{available_columns}"
    end
  end

  def verified_input(available_columns, input)
    available_columns.include?(input)
  end

end

