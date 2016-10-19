module ApplicationHelper


    #根据所在的页面返回完整的标题
    def full_title(page_title = '')
        base_title = "Akagi Project In UniClown"
        if page_title.empty?
            base_title
        else
            page_title + " | " + base_title
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


    def weibo_gettoken(code)
        params = {client_id:"2957192072",
                          client_secret:"55874c06581fcc40e9d083c15f984197",
                          grant_type:"authorization_code",
                          redirect_uri:"http://uniclown.com/login/authorized",
                          code:code
                          }
        uri = URI("https://api.weibo.com/oauth2/access_token")
        res = Net::HTTP.post_form(uri,params)
        token = JSON(res.body)
    end

    def weibo_userinfo(user)
        uri = URI("https://api.weibo.com/2/users/show.json")
        params = {uid:user.weibo,
                          access_token:session[:access_token]}
        uri.query = URI.encode_www_form(params)
        res = Net::HTTP.get_response(uri)
        json = JSON(res.body)
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
