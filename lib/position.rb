class Position
  attr_reader :column, :row

  def initialize(column:, row:)
    @column = column
    @row = row
  end

  def to_h
    { column: column, row: row }
  end

  def to_a
    [column, row]
  end
end
