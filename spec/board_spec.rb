require_relative '../lib/board'
# require_relative '../lib/position'

describe Board do
  describe '#drop' do
    subject(:board_drop) { described_class.new(grid: grid) }
    context 'when the column argument is < 0' do
      subject(:board) { described_class.new }
      it 'retuns nil' do
        invalid_column = -1
        actual = board.drop(column: invalid_column, marker: 'x')
        expect(actual).to be_nil
      end
    end

    context 'when the column argument is bigger than width - 1' do
      subject(:board) { described_class.new}
      it 'returns nil' do
        out_range_column = 10
        actual = board.drop(column: out_range_column, marker: 'x')
        expect(actual).to be_nil
      end
    end

    context 'when the column is full' do
      let(:grid) { [['x', nil, nil], ['x', nil, nil]] }
      it 'returns nil' do
        expect(board_drop.drop(column: 0, marker: 'x')).to eq(nil)
      end

      it 'doesn not change the grid' do
        board_drop.drop(column: 0, marker: 'x')
        expect(board_drop.grid).to eq(grid)
      end
    end

    context 'when the column is empty at the start' do
      let(:grid) do
        Array.new(7) { Array.new(6) }
      end
      it 'return the column' do
        actual = board_drop.drop(column: 0, marker: 'x')
        expect(actual).to eq(0)
      end

      it 'drops the item at the first row' do
        board_drop.drop(column: 0, marker: 'x')
        dropped_grid =
          [
            ['x', nil, nil, nil, nil, nil],
            [nil, nil, nil, nil, nil, nil],
            [nil, nil, nil, nil, nil, nil],
            [nil, nil, nil, nil, nil, nil],
            [nil, nil, nil, nil, nil, nil],
            [nil, nil, nil, nil, nil, nil],
            [nil, nil, nil, nil, nil, nil]
          ]
        expect(board_drop.grid).to eq(dropped_grid)
      end
    end

    context 'when the column has 1 items at the start' do
      let(:grid) { [['x', nil, nil], [nil, nil, nil]] }

      it 'the column now has 2 items' do
        board_drop.drop(column: 0, marker: 'x')
        dropped_grid = [['x', nil, nil], ['x', nil, nil]]
        expect(board_drop.grid).to eq(dropped_grid)
      end
    end
  end

  describe '#any_same_four_in_line?' do
    subject(:board_line) { described_class.new(grid: grid) }

    context 'when there is no 4 same items in any line' do
      let(:grid) do
        [['x', 'o', 'o', nil, nil, nil],
         [nil, 'x', nil, nil, nil, nil],
         [nil, nil, nil, nil, nil, nil],
         [nil, nil, nil, nil, nil, nil],
         [nil, nil, nil, nil, nil, nil],
         [nil, nil, nil, nil, nil, nil],
         [nil, nil, nil, nil, nil, nil]]
      end

      it 'return false' do
        expect(board_line).not_to be_any_same_four_in_line
      end
    end

    context 'when there is a diagonal formed line' do
      let(:grid) do
        [['x', 'o', 'o', 'o', nil, nil],
         [nil, 'x', 'o', 'o', nil, nil],
         [nil, nil, 'x', 'o', nil, nil],
         [nil, nil, nil, 'x', nil, nil],
         [nil, nil, nil, nil, nil, nil],
         [nil, nil, nil, nil, nil, nil],
         [nil, nil, nil, nil, nil, nil]]
      end

      it 'returns true' do
        expect(board_line).to be_any_same_four_in_line
      end
    end

    context 'when there is a vertical formed line' do
      let(:grid) do
        [['x', 'o', 'o', nil, nil, nil],
         [nil, 'o', nil, nil, nil, nil],
         [nil, 'o', nil, nil, nil, nil],
         [nil, 'o', nil, nil, nil, nil],
         [nil, nil, nil, nil, nil, nil],
         [nil, nil, nil, nil, nil, nil],
         [nil, nil, nil, nil, nil, nil]]
      end

      it 'return true' do
        expect(board_line).to be_any_same_four_in_line
      end
    end

    context 'when there is a horizontal formed line' do
      let(:grid) do
        [['x', 'x', 'x', 'x', nil, nil],
         [nil, 'o', nil, nil, nil, nil],
         [nil, 'o', nil, nil, nil, nil],
         [nil, 'o', nil, nil, nil, nil],
         [nil, nil, nil, nil, nil, nil],
         [nil, nil, nil, nil, nil, nil],
         [nil, nil, nil, nil, nil, nil]]
      end

      it 'return true' do
        expect(board_line).to be_any_same_four_in_line
      end
    end
  end

  describe '#full?' do
    subject(:board_full) { described_class.new(grid: grid) }

    context 'if the board is full' do
      let(:grid) do
        Array.new(7) { Array.new(6) { 'x' } }
      end
      it 'returns true' do
        expect(board_full).to be_full
      end
    end

    context 'if the board is not full' do
      let(:grid) do
        [
          ['x', 'x', 'x', 'x', 'o', 'o'],
          [nil, 'o', nil, nil, nil, nil],
          [nil, 'o', nil, nil, nil, nil],
          [nil, 'o', nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil]
        ]
      end
      it 'returns false' do
        expect(board_full).not_to be_full
      end
    end
  end

  describe '#availabe_columns' do
    subject(:board_available) { described_class.new(grid: grid) }
    context 'when all columns are full' do
      let(:grid) do
        Array.new(7) { Array.new(6) { 'x' } }
      end
      it 'returns empty array' do
        expect(board_available.available_columns).to eq([])
      end
    end

    context 'when grid is empty' do
      let(:grid) do
        Array.new(7) { Array.new(6) }
      end

      it 'returns array from 0 to 6' do
        expect(board_available.available_columns).to eq([*(0..5)])
      end
    end

    context 'when all columns are full expect edge columns' do
      let(:grid) do
        [
          ['x', 'x', 'x', 'x', 'o', 'o'],
          ['x', 'x', 'x', 'x', 'o', 'o'],
          ['x', 'x', 'x', 'x', 'o', 'o'],
          ['x', 'x', 'x', 'x', 'o', 'o'],
          ['x', 'x', 'x', 'x', 'o', 'o'],
          ['x', 'x', 'x', 'x', 'o', 'o'],
          [nil, 'x', 'x', 'x', 'o', nil]
        ]
      end

      it 'returns [0, 5]' do
        expect(board_available.available_columns).to eq([0, 5])
      end
    end
  end
end
