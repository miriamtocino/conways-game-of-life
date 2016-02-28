require_relative '../grid'

describe Grid do
  before :each do
    @grid = Grid.new(3, 3)
  end

  describe '#get_coordinates' do
    it 'returns cell coordinates from its index' do
      expect(@grid.get_coordinates(3)).to match_array [0, 1]
    end
  end

  describe '#get_index' do
    it 'returns cell index from its coordinates' do
      expect(@grid.get_index(0, 1)).to eq 3
    end
  end

  describe '#is_inside' do
    context 'cell is inside the grid' do
      it 'returns true' do
        expect(@grid.is_inside?(0, 1)).to be true
      end
    end

    context 'cell is outside the grid given positive coordinates' do
      it 'returns false' do
        expect(@grid.is_inside?(6, 9)).to be false
      end
    end

    context 'cell is outside the grid given negative coordinates' do
      it 'returns false' do
        expect(@grid.is_inside?(-6, -9)).to be false
      end
    end
  end

  describe '#get_neighbours_indexes' do
    context 'central cell' do
      it 'returns an array of all its neighbours indexes' do
        expect(@grid.get_neighbours_indexes(4)).to match_array [0, 1, 2, 3, 5, 6, 7, 8]
      end
    end

    context 'corner cell' do
      it 'returns an array of all its neighbours indexes' do
        expect(@grid.get_neighbours_indexes(8)).to match_array [4, 5, 7]
      end
    end
  end
end
