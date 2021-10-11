require 'matrix'
require_relative 'position'
require_relative 'array'

class Board
  attr_reader :grid

  MATCH_NUM = 4
  WIDTH = 6
  HEIGHT = 7

  def initialize(grid: default_grid)
    @grid = grid
  end

  def drop(column:, marker:)
    return nil if !valid_column?(column) || column_full?(column)

    drop_position = Position.new(row: column_first_empty_row(column), column: column)

    set_cell(position: drop_position, value: marker)
    column
  end

  def any_same_four_in_line?
    line_list.any?(&:four_items_same_value_continous?)
  end

  def full?
    grid.flatten.none?(&:nil?)
  end

  def available_columns
    [*(0..WIDTH - 1)].reject { |i| column_full?(i) }
  end

  def show
    puts board_string
  end

  private

  def valid_column?(column)
    column.between?(0, WIDTH - 1)
  end

  def default_grid
    Array.new(HEIGHT) { Array.new(WIDTH) }
  end

  def column_full?(column)
    grid_column(column).none?(&:nil?)
  end

  def grid_column(column)
    grid.transpose[column]
  end

  def set_cell(position:, value:)
    @grid[position.row][position.column] = value
  end

  def cell(position:)
    @grid[position.row][position.column]
  end

  def column_first_empty_row(column)
    grid_column(column).find_index(&:nil?)
  end

  def line_list
    grid + grid.transpose + diagonal_downward + diagonals_upward
  end

  # https://stackoverflow.com/questions/2506621/ruby-getting-the-diagonal-elements-in-a-2d-array
  def diagonals_upward
    padding = [*0..(HEIGHT - 1)].map { |i| [nil] * i }
    padded = padding.reverse.zip(grid).zip(padding).map(&:flatten)
    padded.transpose.map(&:compact)
  end

  def diagonal_downward
    padding = [*0..(HEIGHT - 1)].map { |i| [nil] * i }
    padded = padding.zip(grid).zip(padding.reverse).map(&:flatten)
    padded.transpose.map(&:compact)
  end

  def board_string
    column_separator = ' | '
    row_seprator = "\n#{Array.new(WIDTH * 3, '-').join}\n"
    grid.map { |row| row.map{ |element| element.nil? ? ' ' : element }.join(column_separator) }.join(row_seprator)
  end
end
