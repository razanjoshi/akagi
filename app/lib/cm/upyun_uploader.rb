require 'upyun'

module CM

	class UpyunUploader

		class << self

			@@upyun = Upyun::Rest.new(Settings.upyun_bucket, Settings.upyun_username, Settings.upyun_password)

			def customize_put(url, tmp_file)
        @@upyun.put(url, File.open(tmp_file))
      end

      def default_put(model, tmp_file)
      	file_ext = File.extname tmp_file
      	path = "/#{model}/#{Time.now.strftime("%Y%m%d")}/#{SecureRandom.uuid}#{file_ext}"
      	metas = @@upyun.put(path, File.new(tmp_file, 'rb'))
      	return [Settings.upyun_bucket_host, path].join('')
      end

      def form_params
        options = {
          bucket:     Settings.upyun_bucket,
          expiration: Time.current.tomorrow.to_i,
          'save-key': '/member/{year}/{mon}/{day}/{filemd5}{.suffix}'
        }.to_json

        data = Hash.new
        data['policy']    = Base64.strict_encode64(options)
        data['signature'] = Digest::MD5.hexdigest("#{data['policy']}&#{Settings.upyun_form_api_secret}")
        data['api_url']   = Settings.upyun_form_api_url
        data['host_url']  = Settings.upyun_bucket_host

        data
      end

		end

	end

end
