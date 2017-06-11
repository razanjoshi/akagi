module ApplicationHelper

  def format_datetime(datetime, style='%Y-%m-%d %H:%M')
    if Time.now - datetime < 1.month
      time_ago_in_words(datetime) + ' ago.'
    else
      datetime.strftime(style)
    end
  end



  def fileread(filename)
    file = File.open(filename,'r')
        content = file.read
    file.close
    return markdown(content)
  end

  def markdown (content)
      pipeline = HTML::Pipeline.new [
        HTML::Pipeline::MarkdownFilter,
      ]
      pipeline.call(content)[:output]
  end




  def weibo_avatar(user)
    json = weibo_userinfo(user)
  end
  def weibo_post(post)
      uri = URI("https://upload.api.weibo.com/2/statuses/upload.json")
      params = {status:URI.encode(post.content),
                      access_token:session[:access_token],
                      pic:post.picture}
      res = Net::HTTP.post_form(uri,params)
      puts JSON(res.body)
  end


  def weibo_upload(params)
      uri =  URI.parse("https://upload.api.weibo.com/2/statuses/upload.json")
      res = Net::HTTP::Post::Multipart.new(path:uri.path,params:{status:URI.encode(params[:micropost][:content]),
                  access_token:session[:access_token],
                  pic:params[:micropost][:picture]}
           )
      n = Net::HTTP.new(uri.host, uri.port)

      n.start do |http|
        @result = http.request(req)
      end
      puts JSON(@result.body)
  end
end
