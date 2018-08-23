class Api::V1::PostsController < Api::V1::BaseController

  before_action :set_case


  def index
    @posts = @case.posts.where('content like ?', '%' + params[:keyword] + '%')
  end

  def add_note
    @key = @case.posts.build(content:params[:key], user_id:1)
    @value = @key.values.build(content:params[:value], case_id:@case.id, user_id:1)
    debugger
    unless @key.save and @value.save
      api_error(status:'fail',result:"保存失败")
    end
  end

  def get_note
    @key = @case.posts.find_by(content: params[:key])
    if @key.nil? or @key.values.empty?
      api_error(status:404,result:"关键字无效或没有结果")
    else
      @value = @key.values.first
    end
  end

  def check_note
    @key = @case.posts.find_by(content: params[:key])
    if @key.nil? or @key.values.empty?
      api_error(status:404,result:"关键字无效或没有结果")
    else
      @value = @key.values.first
      if @value.content == params[:value]
        api_error(status:"success",result:"")
      else
        api_error(status:"fail",result:@value.content)
      end
    end
  end


  private
  def set_case
    @case = Case.find_by(id: params[:case_id])
    if @case.nil?
      api_error(status:404,result:"没有case")
    end
  end

  def api_error(opts = {})
    render json:{
      status:opts[:status],
      result:opts[:result]
    }
  end

end
