class Hand
  attr_reader :current_cards, :highest_card

  SCORES = {
    :no_pair => 0,
    :one_pair => 1,
    :two_pair => 2,
    :three_kind => 3,
    :straight => 4,
    :flush => 5,
    :full_house => 6,
    :four_kind => 7,
    :straight_flush => 8,
    :royal_flush => 9
  }

  def initialize
    @current_cards = []
  end

  def add(*cards)
    cards.each { |card| @current_cards << card }
    sort_cards!
    # determine_score
  end

  def discard(*cards)
    cards.each { |card| @current_cards.delete(card) }
    sort_cards!
  end

  def sort_cards!
    @current_cards = @current_cards.sort_by {|card| Card::VALUE_SCORE[card.value]}
  end

  def determine_score
    if royal_flush
      royal_flush
    elsif straight_flush
      straight_flush
    elsif four_kind
      four_kind
    elsif full_house
      full_house
    elsif flush
      flush
    elsif straight
      straight
    elsif three_kind
      three_kind
    elsif two_pair
      two_pair
    elsif one_pair
      one_pair
    else
      no_pair
    end
  end

  def compare(other_hand)
    other_score = other_hand.determine_score
    score = determine_score

    if SCORES[score] > SCORES[other_score]
      true
    elsif SCORES[score] < SCORES[other_score]
      false
    else
      compare_highest_card(other_hand)
    end
  end

  private

  def same_suit?
    @current_cards.all? { |card| @current_cards[0].suit == card.suit }
  end

  def straight_suit?
    ordered_scores = @current_cards.map { |card| Card::VALUE_SCORE[card.value] }

    ordered_scores.sort.each_cons(2) do |card1, card2|
      return false if card2 - card1 != 1
    end

    true
  end

  def royal_flush
    if straight_suit? && same_suit? && card_values.include?(:ace)
      @highest_card = @current_cards.last
      :royal_flush
    end
  end

  def card_values
    @current_cards.map { |card| card.value }
  end

  def straight_flush
    if straight_suit? && same_suit? && !royal_flush
      @highest_card = @current_cards.last
      :straight_flush
    end
  end

  def four_kind
    if !triple? && card_values.uniq.length == 2
      :four_kind
    end
  end

  def full_house
    return :full_house if triple? && double?
  end

  def count_dups
    dups = Hash.new { |k, v| k[v] = [] }

    card_values.each do |card|
      dups[card] << 1
    end

    dups
  end

  def triple?
    count_dups.select { |k, v| v.length == 3}.length == 1
  end

  def double?
    count_dups.select { |k, v| v.length == 2 }.any? { |v| v.length == 2}
  end

  def flush
    if same_suit?
      @highest_card = @current_cards.last
      :flush
    end
  end

  def straight
    if straight_suit?
      @highest_card = @current_cards.last
      :straight
    end
  end

  def three_kind
    return :three_kind if triple?
  end

  def two_pair
    if count_dups.select { |k, v| v.length == 2}.length == 2
      :two_pair
    else
      false
    end
  end

  def one_pair
    return :one_pair if double?
  end

  def no_pair
    @highest_card = @current_cards.last
    :no_pair
  end

  def compare_highest_card(other_hand)
    if @highest_card.value > other_hand.highest_card.value
      true
    elsif @highest_card.value < other_hand.highest_card.value
      false
    else
      compare_suit(other_hand)
    end
  end

  def compare_suit(other_hand)
    if Card::SUIT_SCORE[@highest_card.suit] > Card::SUIT_SCORE[other_hand.highest_card.suit]
      true
    else
      false
    end
  end
end
