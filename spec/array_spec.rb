require_relative '../lib/array'

describe Array do
  describe '#four_item_same_value_continous?' do
    context 'when there is not 4 items same value continous in array' do
      subject(:array) { ['x','o','o','o', nil, nil, nil] }

      it 'returns false' do
        expect(array).not_to be_four_items_same_value_continous
      end
    end

    context 'when there is 4 items same value continous' do
      subject(:array) { ['x', 'o', 'o', 'o', 'o', nil, nil] }

      it 'retuns true' do
        expect(array).to be_four_items_same_value_continous
      end
    end
  end
end