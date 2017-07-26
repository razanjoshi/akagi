class Wechat::PhotosController < Wechat::BaseController

  skip_before_action :verify_authenticity_token, only: [:create]
  before_action :set_photo, only: :destroy

  def create
    file_params = params.permit(:photo)
    file = file_params[:photo].tempfile

    url = QiniuUploader.default_put(file)

    render json: { success: true,
                  msg: 'photo.uploaded.success',
                  file_path: url }

  end


  def destroy
    @photo.destroy
  end

  private
  def set_photo
    @photo = Photo.find_by(id:params[:id])
  end

end
