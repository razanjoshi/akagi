class Api::V1::DorothyController < Api::V1::BaseController

#  before_action :set_redis

  def receive
    Dorothy.receive(params)
    #@redis.set("Dorothy", @Dorothy)
    api_error(status:'Success',result:"转发成功")
  end

  private
  def set_redis
    @redis = $redis = Redis::Namespace.new("Dorothy", :redis => Redis.new)
  end

end
