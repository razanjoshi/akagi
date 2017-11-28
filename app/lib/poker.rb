class Poker
  def initialize
      suits = ['♣', '♦', '♥', '♠']
      deck = []
      suits.each do |suit|
        13.times do |j|
          i = j + 1
          card = {}
          card[:name] = i > 10 ? suit + ['J', 'Q', 'K'][i-11] : suit + i.to_s
          card[:value] = i
          deck << card
        end
      end
      @deck = deck
  end

  def draw(number, draw = { value: 0, cards:'' })
    if @deck.length >= number
      cards = @deck.sample(number)
      cards.each do |card|
          draw[:value] += card[:value]    #拆封计算方式
          draw[:cards] += ' ' + card[:name]
      end
      @deck = @deck - cards
      return draw
    else
      return false
    end
  end

end
