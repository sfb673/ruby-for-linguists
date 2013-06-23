require 'rspec'

%w(simple_nokogiri_importer).each do |kl|
  require File.join(File.dirname(__FILE__), '..', 'classes', kl)
end

describe SimpleNokogiriImporter do

  it 'should be a singleton' do

    # SimpleNokogiriImporter should be a Singleton
    SimpleNokogiriImporter.should respond_to :instance

    # instance should return an object of the correct type
    SimpleNokogiriImporter.instance.should be_a SimpleNokogiriImporter

  end

  it 'should have correct methods for importing xml' do

    SimpleNokogiriImporter.instance.should respond_to :read_from_string
    SimpleNokogiriImporter.instance.should respond_to :read_from_file

  end

  context 'Import' do

    before :each do
      @xmlstring = <<-XMLDOC
      <Cocktail name="Cosmopolitan">
        <Utensils>
          <Utensil name="Shaker"/>
        </Utensils>
        <Glasses>
          <Glass name="Cocktail Glass"/>
        </Glasses>
        <Ingredients>
          <Ingredient name="lime juice" amount="1 cl"/>
          <Ingredient name="cointreau" amount="1 cl"/>
          <Ingredient name="cranberry juice" amount="2 cl"/>
          <Ingredient name="ice cube" amount="3 pieces"/>
        </Ingredients>
        <Instructions>
          <Step no="1">Add all ingredients to a shaker.</Step>
          <Step no="2">Shake well.</Step>
          <Step no="3">Strain contents into a cocktail glass.</Step>
        </Instructions>
      </Cocktail>
      XMLDOC

      @xmldoc = SimpleNokogiriImporter.instance.read_from_string(@xmlstring)
    end

    it 'should read an example XML file' do
      @xmldoc.should_not be nil
    end

    context "Contents" do

      before :each do

        @cocktail_element = @xmldoc.root

      end

      it 'should know the correct cocktail name' do
        @xmldoc.root['name'].should eq 'Cosmopolitan'
      end

      context 'Utensils' do

        it 'should know the correct number of utensils' do
          @cocktail_element.xpath('./Utensils/Utensil').size.should eq 1
        end

        it 'should know that the first utensil is a shaker' do

        end

      end

      context 'Glasses' do

        it 'should know the correct number of glasses' do
          # Aufgabe: Vervollständigen Sie den Test und bringen Sie ihn zum Laufen.
        end

        it 'should know that the first glass is a cocktail glass' do
          # Aufgabe: Vervollständigen Sie den Test und bringen Sie ihn zum Laufen.
        end

      end

      context 'Ingredients' do

        context 'which ingredients' do

          it 'should know the correct number of ingredients' do
            # Aufgabe: Vervollständigen Sie den Test und bringen Sie ihn zum Laufen.
          end

          it 'should know that lime juice is part of the recipe' do
            @cocktail_element.xpath('./Ingredients/Ingredient[@name="lime juice"]').should_not be_empty
          end

          it 'should know that cointreau is part of the recipe' do
            # Aufgabe: Vervollständigen Sie den Test und bringen Sie ihn zum Laufen.
          end

          it 'should know that cranberry juice is part of the recipe' do
            # Aufgabe: Implementieren.
          end

        end

        context 'correct amount of each ingredient' do

          it 'should know the correct amount of lime juice' do
            @cocktail_element.xpath('./Ingredients/Ingredient[@name="lime juice"]').first['amount'].should eq '1 cl'
          end

          it 'should know the correct amount of cointreau' do
            # Aufgabe: Vervollständigen Sie den Test und bringen Sie ihn zum Laufen.
          end

          it 'should know the correct amount of cranberry juice' do
            # Aufgabe: Vervollständigen Sie den Test und bringen Sie ihn zum Laufen.
          end

        end

      end

      context 'Instructions' do

        it 'should know how many instructions there are' do
          # Aufgabe: Vervollständigen Sie den Test und bringen Sie ihn zum Laufen.
        end

        it 'should know that the first instruction step has to do with all ingredients and the shaker' do
          puts @cocktail_element.xpath('./Instructions/Step')[0]
          @cocktail_element.xpath('./Instructions/Step')[0].text.should match /all ingredients/
          @cocktail_element.xpath('./Instructions/Step')[0].text.should match /shaker/
        end

        it 'should know that the second instruction step instructs to shake' do
          # Aufgabe: Vervollständigen Sie den Test und bringen Sie ihn zum Laufen.
        end

        it 'should know that the third instruction step has to do with the cocktail glass' do
          # Aufgabe: Vervollständigen Sie den Test und bringen Sie ihn zum Laufen.
        end

      end

    end

  end


end