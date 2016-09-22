require 'rspec'
require 'card'

describe Card do
  subject(:card) { Card.new(:spade, 3) }

  describe '#initialize' do
    it 'has a value' do
      expect(card.value).to eq(3)
    end

    it 'has a type' do
      expect(card.suit).to eq(:spade)
    end

    it 'value/type can\'t be changed' do
      expect{card.value = :heart}.to raise_error(NoMethodError)
    end
  end
end
