class Cpanel::CasesController < Cpanel::BaseController

	before_action :set_case, only: [:edit, :update, :destroy]

	def index
    @cases = Case.level(1).paginate(page: params[:page])
  end

	def new
		@case = Case.new
	end

	def create
		@case = Case.new case_params
		if @case.save
			redirect_to [:cpanel, :cases], notice:"创建成功"
		else
			render :new
		end
	end

	def edit
	end

	def update
		@case.update_attributes case_params
		redirect_to [:cpanel, :cases], notice:"更新成功"
	end

	def destroy
		@case.delete
		redirect_to [:cpanel, :cases], notice:"删除成功"
	end

	def get_options
    thecase = Case.find_by(id: params[:id])
		if thecase
		  options = [[thecase.id, thecase.title]]
		  thecase.subcases.each do |s|
		    options << [s.id, s.title]
		  end
			options << [0, '重置']
		  render :json => options
		else
			options = []
			Case.level(1).each do |s|
		    options << [s.id, s.title]
		  end
			render :json => options
		end
  end


	private
	def case_params
		params.require(:case).permit(:level, :title, :content, :parent_id)
	end

	def set_case
		@case = Case.find_by(id: params[:id])
	end

end
