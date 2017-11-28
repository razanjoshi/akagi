class Dorothy

	class << self
    def receive(params)
      @params = params
      if params['content'].include? '牛牛'
        niuniu
      elsif is_game_on? or params['content'].include?('德州')
        play_a_game
      else
        puts params['content'] if Rails.env.development?
      end
    end

    def play_a_game
      if @params['content'].include? '德州'
        holdem
      elsif @params['content'].include? '开'
        $game.start
      elsif @params['content'].include? '继续发'
        $game.draw
      elsif @params['content'].include? '结束'
        $game = nil
      else
        not_a_game
      end
    end

    def not_a_game
      puts @params['content'] if Rails.env.development?
    end

    def is_game_on?
      $game and $game.status != 4
    end

    def niuniu
      game = Poker.new
      hand = game.draw(5)
      word = @params[:user_name] ? "@" + @params[:user_name] + "
      "+ hand[:cards] : hand[:cards]
      send_msg(word)
    end

    def holdem
      if !$game || $game.status == 4
        $game = Game.new(1, @params[:user_name], @params['bot_id'], @params['user_id'])
        send_msg '游戏开始，输入德州进行报名'
        return
      elsif $game.status == 0
        $game.sign_player(@params[:user_name])
        send_msg '报名成功,目前游戏人数' + $game.players.length.to_s
        return
      end
    end


    def send_msg(word, bot_id = @params['bot_id'], uid = @params['user_id'] )
      uri =  URI.parse("http://127.0.0.1:8090/api/send_msg_by_uid/")
      data = {
        'word': word,
        'bot_id': bot_id,
        'uid': uid
        }
      uri.query = URI.encode_www_form(data)
      res = Net::HTTP.get_response(uri)
    end
  end
end
