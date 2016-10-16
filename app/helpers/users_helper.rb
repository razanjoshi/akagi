module UsersHelper
    def gravatar_for (user, size:80)
        if user.weibo
            gravatar_url = "http://tp1.sinaimg.cn/#{user.weibo}/180/0/1"
        else
            gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
            gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
        end
            image_tag(gravatar_url, alt:user.name, class:"gravatar",size:"#{size}x#{size}")


    end
end
