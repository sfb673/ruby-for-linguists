
%w(chart chart_entry).each do |k|
  require "../classes/#{k}"
end

describe ChartEntry do


  context 'Construction' do

    before :each do
      @start_index = 0
      @end_index = 2
      @left = 'NP'
      @right = ['D','A','P','N']
      @dot_position = 2
      @inactive = ['D','A']
      @active = ['P','N']
      @chart_entry = ChartEntry.new @start_index, @end_index, @left, @right, @dot_position
    end

    it 'has a correct start index' do
      @chart_entry.start_index.should eq @start_index
    end

    it 'has a correct end index' do
      @chart_entry.end_index.should eq @end_index
    end

    it 'has a correct left symbol' do
      @chart_entry.left_symbol.should eq @left
    end

    it 'has a correct right symbol' do
      @chart_entry.right_symbols.should eq @right
    end

    it 'has a correct dot position' do
      @chart_entry.dot_position.should eq @dot_position
    end

    it 'has a correct inactive part' do
      @chart_entry.inactive_part.should eq @inactive
    end

    it 'has a correct active part' do
      @chart_entry.active_part.should eq @active
    end

  end

  context 'Checkers' do

    before :each do
      @start_index = 0
      @end_index = 2
      @left = 'NP'
      @right = ['D','A','P','N']
      @dot_position = 2
      @inactive = ['D','A']
      @active = ['P','N']
      @chart_entry = ChartEntry.new @start_index, @end_index, @left, @right, @dot_position
    end

    it 'knows whether the left symbol matches' do
      @chart_entry.left_symbol_matches?('NP').should be_true
      @chart_entry.left_symbol_matches?('X').should be_false
    end

    it 'knows whether the active part starts with a single symbol' do
      @chart_entry.active_part_starts_with?('P').should be_true
      @chart_entry.active_part_starts_with?('X').should be_false
    end

    it 'knows whether the active part starts with an array containing a single symbol' do
      @chart_entry.active_part_starts_with?(['P']).should be_true
      @chart_entry.active_part_starts_with?(['X']).should be_false
    end

    it 'knows whether the active part starts with an array containing multiple symbols' do
      @chart_entry.active_part_starts_with?(['P','N']).should be_true
      @chart_entry.active_part_starts_with?(['X','N']).should be_false
      @chart_entry.active_part_starts_with?(['P','N','X']).should be_false
    end

    it 'knows whether the index range matches' do
      @chart_entry.range_is?(0,2).should be_true
      @chart_entry.range_is?(1,2).should be_false
    end

  end

end