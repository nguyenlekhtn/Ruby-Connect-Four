require_relative '../lib/board'

describe Board do
  describe '#initialize' do
    it 'intiailize a board with a grid' do
      expect { described_class.new(grid: 'grid') }.not_to raise_error
    end

    context 'when given no grid augument' do
      subject(:board_initialize){ described_class.new }
      it 'have a default grid with 7 rows' do
        row_size = board_initialize.grid.size
        expect(row_size).to eq(7)
      end

      it 'each row has size of 6' do
        board_initialize.grid.each do |row|
          expect(row.size).to eq(6)
        end
      end
    end
  end
  
  describe '#drop' do
    subject(:board_drop) { described_class.new(grid: grid) }
    context 'when the column is full' do
      let(:grid) { [['x', nil, nil], ['x', nil, nil]] }
      it 'returns nil' do
        expect(board_drop.drop(column: 0, marker: 'x')).to eq(nil)
      end

      it 'doesn\'t change the grid' do
        board_drop.drop(column: 0, marker: 'x')
        expect(board_drop.grid).to eq(grid)
      end
    end

    context 'when the column is not full' do
      let(:grid) { [[nil, nil, nil], ['x', nil, nil]] }
      it 'return the column' do
        actual = board_drop.drop(column: 0, marker: 'x')
        expect(actual).to eq(0)
      end
    end
  end
end
