class Cpanel::BaseController < ApplicationController

	layout 'cpanel'

  http_basic_authenticate_with name: "clown", password: "123456"

  def index
  end

end
