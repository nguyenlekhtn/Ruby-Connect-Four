require_relative '../lib/player'
require_relative '../lib/board'

describe Player do
  describe '#play_turn' do

    subject(:player_play) { described_class.new(marker: 'x', board: board) }
    let(:board) { instance_double(Board) }



    context 'when playing turn' do
      before do
        allow(player_play).to receive(:gets).and_return('3')
      end

      it 'sends drop to board with keyword args column is from input and marker is its marker' do
        expect(board).to receive(:drop).with(column: 3, marker: 'x')
        player_play.play_turn
      end
    end

    context 'when'
  end
end
