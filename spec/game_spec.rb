require_relative '../lib/board'
require_relative '../lib/game'
require_relative '../lib/player'


describe Game do
  describe "#show_board" do
    subject(:game_show) { described_class.new(board: board) }
    let(:board) { instance_double(Board) }

    it 'sends show to Board' do
      expect(board).to receive(:show)
      game_show.show_board
    end
  end

  describe "#create_player" do
    subject(:game_player) { described_class.new }

    it 'creates player with given name and marker' do
      allow(game_player).to receive(:player_name).and_return("foo")
      allow(game_player).to receive(:player_marker).and_return("bar")
      expect(Player).to receive(:new).with(name: "foo", marker: "bar")
      game_player.create_player(0, 'x')
    end
  end

  describe '#board_full?' do
    subject(:game_full) { described_class.new(board: board) }
    let(:board) { instance_double(Board) }

    it 'sends full to Board' do
      expect(board).to receive(:full?)
      game_full.board_full?
    end
  end

  describe '#board_available_columns' do
    subject(:game_available) { described_class.new(board: board) }
    let(:board) { instance_double(Board) }

    it 'sends available_columns to Board' do
      expect(board).to receive(:available_columns)
      game_available.board_available_columns
    end
  end

  describe '#board_drop_on_column' do
    subject(:game_drop) { described_class.new(board: board, current_player: player) }
    let(:board) { instance_double(Board) }
    let(:player) { instance_double(Player) }

    before do
      allow(player).to receive(:marker).and_return('x')
    end

   
    it 'sends drop to board with corresponed column' do
      expect(board).to receive(:drop).with(column: 2, marker: 'x')
      game_drop.board_drop_on_column(2)
    end
  end

  describe '#turn' do
    subject(:game_turn) { described_class.new(current_player: player) }
    let(:player) { instance_double(Player) }

    before do
      allow(game_turn).to receive(:board_drop_on_column)
    end

    it 'sends column_input to current_player' do
      expect(player).to receive(:column_input).with(game_turn.board_available_columns)
      game_turn.turn
    end
  end

  describe '#winner?' do
    subject(:game_winner) { described_class.new(board: board) }
    let(:board) { instance_double(Board) }

    it 'sends any_same_four_in_line? to board' do
      expect(board).to receive(:any_same_four_in_line?)
      game_winner.winner?
    end
  end

  describe '#current_player_name' do
    subject(:game_name) { described_class.new(current_player: player) }
    let(:player) { instance_double(Player) }

    it 'sends name to current_player' do
      expect(player).to receive(:name)
      game_name.current_player_name
    end
  end

  describe '#current_player_marker' do
    subject(:game_marker) { described_class.new(current_player: player) }
    let(:player) { instance_double(Player) }

    it 'sends marker to current_player' do
      expect(player).to receive(:marker)
      game_marker.current_player_marker
    end
  end
end