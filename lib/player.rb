require_relative 'board'
require_relative 'text_content'

class Player
  include TextContent
  attr_reader :marker, :name

  def initialize(marker:, name: nil)
    @name = name
    @marker = marker
  end

  def column_input(available_columns)
    input_help(available_columns)
    user_input(available_columns)
  end

  def user_input(available_columns)
    loop do
      user_input = gets.chomp
      verified_input = verified_input(available_columns, user_input.to_i) if user_input.match(/^\d+$/)
      return verified_input if verified_input

      puts warning_message('column_error')
    end
  end

  private

  def input_help(available_columns)
    puts <<~MSG
      Please enter the column you want to drop your marker. Available columns: #{available_columns}
    MSG
  end

  def verified_input(available_columns, input)
    return input if available_columns.include?(input)
  end
end
