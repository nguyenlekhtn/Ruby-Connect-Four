require_relative '../lib/player'
require_relative '../lib/board'
require_relative '../lib/text_content'

describe Player do
  describe '#user_input' do
    subject(:game_input) { described_class.new(marker: 'x') }
    let(:available_columns) { [1, 2, 3] }
    let(:error_msg) { TextContent.warning_message('column_error') }

    context 'when user number is among available columns' do
      before do
        valid_input = '3'
        allow(game_input).to receive(:gets).and_return(valid_input)
      end

      it 'stop loop and does not display error message' do
        expect(game_input).to_not receive(:puts).with(error_msg)
        game_input.user_input(available_columns)
      end

      it 'returns the integer of the input' do
        expect(game_input.user_input(available_columns)).to eq(3)
      end
    end

    context 'when user input an incorrect value once, then a valid input' do
      before do
        invaid_input = '4'
        valid_input = '3'
        allow(game_input).to receive(:gets).and_return(invaid_input, valid_input)
      end

      it 'complete loop and display error message once' do
        expect(game_input).to receive(:puts).with(error_msg).once
        game_input.user_input(available_columns)
      end
    end

    context 'when user inputs two incorrect value once, then a valid input' do
      before do
        symbol = '+'
        out_range = '6'
        valid_input = '3'
        allow(game_input).to receive(:gets).and_return(symbol, out_range, valid_input)
      end

      it 'complete loop and display error message twice' do
        expect(game_input).to receive(:puts).with(error_msg).twice
        game_input.user_input(available_columns)
      end
    end
  end
end
