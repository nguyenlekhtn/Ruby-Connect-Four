require_relative '../lib/board'
require_relative '../lib/game'


describe Game do
  describe "#show_board" do
    subject(:game_show) { described_class.new(board: board) }
    let(:board) { instance_double(Board) }

    it 'sends show to Board' do
      expect(board).to receive(:show)
      game_show.show_board
    end
  end
end