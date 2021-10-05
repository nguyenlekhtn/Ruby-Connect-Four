class Board
  attr_reader :grid

  def initialize(grid: default_grid)
    @grid = grid
  end

  def drop(column:, marker:)
    return nil if column_full?(column: column)

    column
  end

  private

  def default_grid
    Array.new(7) { Array.new(6, '') }
  end

  def column_full?(column:)
    grid_column(column: column).none?(&:nil?)
  end

  def grid_column(column:)
    grid.transpose[column]
  end
end
