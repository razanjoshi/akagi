class Game
  attr_accessor :status,:players

  class Player

    def initialize(name)
      @name = name
    end

    def get_hand(hand)
      @hand = hand
      return @name + ":
      " + @hand[:cards]
    end

  end


  def initialize(type, player, bot_id, uid)
    @bot_id = bot_id
    @uid = uid
    @deck = Poker.new
    @status = 0
    @players = []
    @players[0] = Player.new(player)
  end

  def sign_player(player)
    @players << Player.new(player)
  end

  def start
    if @status == 0
      @players.each do |player|
        if cards = @deck.draw(2)
          msg = player.get_hand(cards)
          Dorothy.send_msg msg, @bot_id, @uid
        end
      end
      @board = @deck.draw(3)
      msg = "底牌:
      " + @board[:cards]
      @status = 1
      Dorothy.send_msg msg, @bot_id, @uid
    end
  end

  def draw
    if @status < 3 && @status > 0
      @board = @deck.draw(1, @board)
      msg = "底牌:
      " + @board[:cards]
      @status += 1
      Dorothy.send_msg msg, @bot_id, @uid
    end
    if @status == 3
      self.finish
    end
  end

  def finish
    @status = 4
    Dorothy.send_msg '游戏结束', @bot_id, @uid
  end

end
