require 'spec_helper'

describe GridCell do
  before :each do
    @grid_cell = GridCell.new
  end

  describe '#set_alive' do
    it 'sets the cell to be alive (true)' do
      expect { @grid_cell.set_alive }.to change{ @grid_cell.status }
        .from(false).to(true)
    end
  end
end
