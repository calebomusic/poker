class Card
  attr_reader :suit, :value

  SUITS = [:heart, :spade, :clover, :diamond]

  VALUES = [2, 3, 4, 5, 6, 7, 8 ,9, 10, :jack, :queen, :king, :ace]

  VALUE_SCORE = {
    2 => 0,
    3 => 1,
    4 => 2,
    5 => 3,
    6 => 4,
    7 => 5,
    8 => 6,
    9 => 7,
    10 => 8,
    :jack => 9,
    :queen => 10,
    :king => 11,
    :ace => 12
  }

  SUIT_SCORE = {
    :clover => 0,
    :diamond => 1,
    :heart => 2,
    :spade => 3
  }

  def initialize(suit, value)
    @suit = suit
    @value = value
  end
end
