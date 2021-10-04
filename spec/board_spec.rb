require_relative '../lib/board'

describe Board do
  describe '#initialize' do
    it 'intiailize a board with a grid' do
      expect { described_class.new(grid: 'grid') }.not_to raise_error
    end
  end
end
