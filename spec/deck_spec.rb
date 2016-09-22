require 'rspec'
require 'deck'

describe Deck do
  subject(:deck) { Deck.new }

  describe '#initialize' do
    # 52 cards in an array
    it 'contains 52 unique cards' do
      expect(deck.cards.length).to eq(deck.cards.uniq.length)
      expect(deck.cards.length).to eq(52)
    end

    it 'contains 13 cards of all four suits' do
      suits = []
      [:heart, :spade, :clover, :diamond].each do |suit|
        suits << deck.cards.select { |card| card.suit == suit }
      end

      expect(suits.all? { |suit| suit.length == 13 }).to eq(true)
    end
  end

  describe '#shuffle' do
    it 'shuffles the deck' do
      expect(deck.cards).to_not eq(deck.shuffle.cards)
    end
  end
end
