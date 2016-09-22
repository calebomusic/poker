require_relative 'card'

class Deck
  attr_reader :cards

  def initialize(cards = default_deck)
    @cards = cards
  end

  def shuffle
    @cards = @cards.shuffle
    self
  end

  private
  
  def default_deck
    cards = []
    Card::SUITS.each do |suit|
      Card::VALUES.each do |value|
        cards << Card.new(suit, value)
      end
    end

    cards
  end

end
