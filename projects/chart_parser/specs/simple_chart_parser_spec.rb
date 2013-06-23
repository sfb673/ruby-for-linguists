
%w(lexicon lex_entry).each do |k|
  require "../../mini-english/classes/#{k}"
end

%w(chart chart_entry rule rule_set simple_chart_parser).each do |k|
  require "../classes/#{k}"
end

describe Chart do

  before :each do

    # Hier wird eine reduzierte Version von Mini-English
    # eingesetzt - versuchen Sie mal, ob das volle Inventar
    # von Mini-English in Ihrer Ruby-Umgebung noch läuft,
    # ohne dass Sie minutenlang warten müssen...

    @rule_set = RuleSet.new
    @rule1 = Rule.new 'NP', ['N']
    @rule2 = Rule.new 'NP', ['AD','N']
    @rule3 = Rule.new 'NP_', ['D','NP']
    @rule4 = Rule.new 'PP_', ['P','NP_']
    @rule5 = Rule.new 'NP_', ['NP_','PP_']

    @rule6 = Rule.new 'D', ['a']
    @rule7 = Rule.new 'D', ['the']
    @rule8 = Rule.new 'AD', ['happy']
    @rule9 = Rule.new 'AD', ['sad']
    @rule10 = Rule.new 'N', ['cat']
    @rule11 = Rule.new 'N', ['zombie']
    @rule12 = Rule.new 'P', ['with']
    @rule13 = Rule.new 'P', ['for']

    @rule_set.add_rule @rule1
    @rule_set.add_rule @rule2
    @rule_set.add_rule @rule3
    @rule_set.add_rule @rule4
    @rule_set.add_rule @rule5
    @rule_set.add_rule @rule6
    @rule_set.add_rule @rule7
    @rule_set.add_rule @rule8
    @rule_set.add_rule @rule9
    @rule_set.add_rule @rule10
    @rule_set.add_rule @rule11
    @rule_set.add_rule @rule12
    @rule_set.add_rule @rule13

    @lexicon = Lexicon.new

    @scp = SimpleChartParser.new @lexicon, @rule_set
    @scp.set_input "the happy zombie with a sad cat"
  end

  context 'Construction' do

    it 'can be constructed' do

      @scp.should_not be nil

    end

  end

  context 'init charts' do

    it 'can init the charts' do
      @scp.register_start_values('NP_')
    end

    context 'expand' do

      it 'can expand charts' do
        @scp.register_start_values('NP_')
        @scp.expand
        puts @scp.chart
        @scp.chart.should_not be nil
      end

    end

    context 'scan' do

      it 'can scan charts' do
        @scp.register_start_values('NP_')
        @scp.expand
        @scp.scan
        @scp.chart.should_not be nil
      end
    end

    context 'parse' do

      it 'can parse' do
        @scp.parse "a zombie with a cat", 'NP_'
      end

    end
  end




end