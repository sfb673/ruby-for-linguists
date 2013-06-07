require 'rspec'

describe String do

  it 'returns the correct length for a string' do
    "Hello World!".size.should eq 12
  end

end