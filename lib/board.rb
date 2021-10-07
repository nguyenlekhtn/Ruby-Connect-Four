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
    return nil if column_full?(column)

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

  private

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

  # def column_top_stack_row(column)
  #   first_empty_row = column_first_empty_row(column)
  #   raise 'Column is empty' if first_empty_row.zero?

  #   first_empty_row - 1
  # end

  # def vector_list(size)
  #   [Vector[size, 0], Vector[0, size], Vector[size, size], Vector[size, -size]]
  # end

  # def count_same_marker_from_start(array)
  #   first, *rest = array
  #   count = 0
  #   rest.each do |position|
  #     break if cell(**position) != cell(**first)

  #     count += 1
  #   end
  #   count
  # end

  # def line_contained_4?(vector:, start_position:)
  #   array_from_vector = vector2positions(vector: vector, start_position: start_position)
  #   match_num_in_arr = count_same_marker_from_start(array_from_vector)

  #   return true if match_num_in_arr + 1 == MATCH_NUM

  #   opposite_array = vector2positions(vector: vector * -1, start_position: start_position)
  #   match_num_in_opp_arr = count_same_marker_from_start(opposite_array)

  #   line_match_num = match_num_in_arr + match_num_in_opp_arr + 1
  #   return true if line_match_num == MATCH_NUM

  #   false
  # end

  # def vector2positions(vector:, start_position:)
  #   # new_position_proc = lambda do |column, row|
  #   #   p start_position
  #   #   Position.new(column: start_position.column + column, row: start_position.row + row)
  #   # end
  #   vector.map do |column, row|
  #     p column, row
  #     Position.new(column: start_position.column + column, row: start_position.row + row)
  #             .select(&:in_range?)
  #   end
  # end

  # def in_range?(position)
  #   position.row.between(0, HEIGHT - 1) && position.column.between(0, WIDTH - 1)
  # end

  def line_list
    grid + grid.transpose + diagonal_downward + diagonals_upward
  end

  # def cross_lines_l2r
  #   (0..(WIDTH - HEIGHT + 1)).each_with_object([]) do |memo, current|
  #     memo + (0..HEIGHT - 1).map { |i| grid[i][i + current] }
  #   end
  # end

  # def cross_lines_r2l
  #   (0..(WIDTH - HEIGHT + 1)).each_with_object([]) do |memo, current|
  #     memo + (0..HEIGHT - 1).map { |i| grid[i][i + current] }
  #   end
  # end

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
end

