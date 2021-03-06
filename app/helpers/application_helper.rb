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

  def markdown(content)
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

  def weibo_share(post)

    uri =  URI.parse("https://api.weibo.com/2/statuses/share.json")
    content = weibo_content(post)
    if post.photos.empty?
      params = {
        status:content,
        access_token:session[:access_token]
                    }
      res = Net::HTTP.post_form(uri,params)
    else
      require 'net/http/post/multipart'
      tempfile = open(post.photos.first.image);
      req = Net::HTTP::Post::Multipart.new uri.path,
        {"pic" => UploadIO.new(tempfile, "image/jpeg", "image.jpg"),
          "access_token" => session[:access_token],
          "status" => URI.encode(content)
        }
        n = Net::HTTP.new(uri.host, uri.port)
        n.use_ssl = true
        n.start do |http|
          res = http.request(req)
        end
    end
    json = JSON(res.body)
    if json['error']
      puts json
    end
  end

  def weibo_content(post)
    content = ""
    markdown(post.content).to_s.lines.each_with_index do |line, index|
      unless line.include?('img') || content.length > 137
        content += ActionController::Base.helpers.sanitize(line, tags:[])
      end
    end
    content = "『#{post.case.title}』查看全部-> http://uniclown.com/blog/cases/#{post.case.id}\n" + content;
    if content.length > 140
      content = content.lines[0..-2] + '...'
    end
    return content
  end

end
