require 'rspec'
require 'hand'
require 'card'

describe Hand do
  subject(:hand) { Hand.new }
  let(:fail_hand) { Hand.new }
  let(:spade_ace) { double("spade_ace",:value => :ace, :suit => :spade) }
  let(:spade_king) { double("spade_king",:value => :king, :suit => :spade) }
  let(:spade_queen) { double("spade_queen",:value => :queen, :suit => :spade) }
  let(:spade_jack) { double("spade_jack",:value => :jack, :suit => :spade) }
  let(:spade_10) { double("spade_10",:value => 10, :suit => :spade) }
  let(:spade_9) { double("spade_9",:value => 9, :suit => :spade) }
  let(:spade_2) { double("spade_2",:value => 2, :suit => :spade) }
  let(:heart_9) { double("heart_9",:value => 9, :suit => :heart) }
  let(:heart_king) { double("heart_king",:value => :king, :suit => :heart) }
  let(:clover_king) { double("clover_king",:value => :king, :suit => :clover) }
  let(:diamond_king) { double("diamond_king",:value => :king, :suit => :diamond) }

  before(:each) do
    fail_hand.add(heart_king, spade_queen, spade_10, spade_2, heart_9)
  end

  describe '#initialize' do
    it 'initializes with an empty current cards array' do
      expect(hand.current_cards).to be_empty
    end
  end

  describe '#add and #discard' do
    before(:each) do
      hand.add(spade_ace, spade_2, spade_10)
    end

    describe '#add' do
      it 'adds n number of cards' do
        expect(hand.current_cards.length).to eq(3)
      end
    end

    describe '#discard' do
      it 'discards n cards from hand' do
        hand.discard(spade_2, spade_ace)
        expect(hand.current_cards.length).to eq(1)
      end
    end
  end

  describe '#determine_score' do
    describe 'royal flush' do

      before(:each) do
        hand.add(spade_ace, spade_king, spade_queen, spade_jack, spade_10)
      end

      it 'returns a royal flush' do
        expect(hand.determine_score).to eq(:royal_flush)
      end

      it 'does not return a royal flush' do
        expect(fail_hand.determine_score).to_not eq(:royal_flush)
      end
    end

    describe 'straight flush' do
      before(:each) do
        hand.add(spade_9, spade_king, spade_queen, spade_jack, spade_10)
      end

      it 'returns a straight flush' do
        expect(hand.determine_score).to eq(:straight_flush)
      end

      it 'does not return a straight flush' do
        expect(fail_hand.determine_score).to_not eq(:straight_flush)
      end
    end

    describe 'four of a kind' do
      before(:each) do
        hand.add(spade_king, diamond_king, heart_king, clover_king, spade_10)
      end

      it 'returns a four of a kind' do
        expect(hand.determine_score).to eq(:four_kind)
      end

      it 'does not return a four of a kind' do
        expect(fail_hand.determine_score).to_not eq(:four_kind)
      end
    end

    describe 'full house' do
      before(:each) do
        hand.add(spade_king, diamond_king, clover_king, spade_9, heart_9)
      end

      it 'returns a full house' do
        expect(hand.determine_score).to eq(:full_house)
      end

      it 'does not return a full house' do
        expect(fail_hand.determine_score).to_not eq(:full_house)
      end
    end

    describe 'flush' do
      before(:each) do
        hand.add(spade_ace, spade_king, spade_queen, spade_jack, spade_9)
      end

      it 'returns a flush' do
        expect(hand.determine_score).to eq(:flush)
      end

      it 'does not return a flush' do
        expect(fail_hand.determine_score).to_not eq(:flush)
      end
    end

    describe 'straight' do
      before(:each) do
        hand.add(heart_9, spade_king, spade_queen, spade_jack, spade_10)
      end

      it 'returns a straight' do
        expect(hand.determine_score).to eq(:straight)
      end

      it 'does not return a straight' do
        expect(fail_hand.determine_score).to_not eq(:straight)
      end
    end

    describe 'three of a kind' do
      before(:each) do
        hand.add(diamond_king, spade_king, clover_king, heart_9, spade_10)
      end

      it 'returns a three of a kind' do
        expect(hand.determine_score).to eq(:three_kind)
      end

      it 'does not return a three of a kind' do
        expect(fail_hand.determine_score).to_not eq(:three_kind)
      end
    end

    describe 'two pair' do
      before(:each) do
        hand.add(diamond_king, spade_king, spade_queen, heart_9, spade_9)
      end

      it 'returns a two pair' do
        expect(hand.determine_score).to eq(:two_pair)
      end

      it 'does not return a two pair' do
        expect(fail_hand.determine_score).to_not eq(:two_pair)
      end
    end

    describe 'one pair' do
      before(:each) do
        hand.add(diamond_king, spade_king, spade_queen, spade_jack, spade_10)
      end

      it 'returns a one pair' do
        expect(hand.determine_score).to eq(:one_pair)
      end

      it 'does not return a one pair' do
        expect(fail_hand.determine_score).to_not eq(:one_pair)
      end
    end

    describe 'no pair / highest card' do
      it 'returns a no pair' do
        expect(fail_hand.determine_score).to eq(:no_pair)
      end
    end
  end

  describe '#compare' do
    before(:each) do
      hand.add(spade_ace, spade_king, spade_queen, spade_jack, spade_10)
    end

    it 'returns true when hand wins as royal flush' do
      expect(hand.compare(fail_hand)).to eq(true)
    end

    it 'returns false when hand loses to a royal flush' do
      expect(fail_hand.compare(hand)).to eq(false)
    end

    describe 'highest card comparison' do
      before(:each) do
        hand.discard(spade_ace, spade_king, spade_queen, spade_jack, spade_10)
        hand.add(heart_9, spade_queen, spade_10, spade_2, spade_ace)
      end
      it 'returns true when hand has the highest card' do
        expect(hand.compare(fail_hand)).to eq(true)
      end

      it 'returns false when hand loses to highest card' do
        expect(fail_hand.compare(hand)).to eq(false)
      end
    end
  end
end
