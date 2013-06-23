
%w(chart chart_entry).each do |k|
  require "../classes/#{k}"
end

describe Chart do

  before :each do
    @chart_item_data = [
        [0, 2, 'NP', ['D', 'N'], 0],
        [1, 3, 'NP', ['D', 'N'], 2],
        [0, 2, 'VP', ['D', 'N'], 1],
        [0, 2, 'NP', ['X', 'Y'], 1],
        [0, 2, 'NP', ['D', 'Y'], 1],
    ]

    @chart = Chart.new
    @chart_item_data.each do |item|
      @chart.add_entry *item
    end
  end

  context 'Construction' do


  end

  context 'chart has find method' do

    it 'responds to find method' do
      @chart.should respond_to :find
    end

  end

  context 'default behavior of find method' do
    it 'chart returns all items when find has no parameters' do
      r = @chart.find
      r.size.should eq @chart_item_data.size
    end
  end

  context 'finding charts with certain properties' do

    it 'returns correct data for given ranges' do
      r = @chart.find(:range => [0,2])
      r.size.should eq 4
      r = @chart.find(:range => [1,3])
      r.size.should eq 1
      r = @chart.find(:range => [1,2])
      r.size.should eq 0
    end

    it 'returns correct data for given LHS' do
      r = @chart.find :left_symbol => 'NP'
      r.size.should eq 4
      r = @chart.find :left_symbol => 'VP'
      r.size.should eq 1
    end

    it 'returns correct data for given RHS' do
      r = @chart.find :right_symbols_start_with => []
      r.size.should eq 5
      r = @chart.find :right_symbols_start_with => ['D']
      r.size.should eq 4
      r = @chart.find :right_symbols_start_with => ['D','N']
      r.size.should eq 3
      r = @chart.find :right_symbols_start_with => ['X']
      r.size.should eq 1
      r = @chart.find :right_symbols_start_with => 'X'
      r.size.should eq 1
    end

    it 'returns correct data for given active part start' do
      r = @chart.find :active_part_starts_with => []
      r.size.should eq 5
      r = @chart.find :active_part_starts_with => 'N'
      r.size.should eq 1
      r = @chart.find :active_part_starts_with => ['N']
      r.size.should eq 1
      r = @chart.find :active_part_starts_with => 'Y'
      r.size.should eq 2
      r = @chart.find :active_part_starts_with => ['Y']
      r.size.should eq 2
    end

    it 'returns correct data for given active part start' do
      r = @chart.find :complete => true
      r.size.should eq 1
      r = @chart.find :complete => false
      r.size.should eq 4
    end

  end



end