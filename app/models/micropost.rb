class Micropost < ApplicationRecord
  belongs_to :user
  belongs_to :case
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence:true
  validates :content, presence:true
  mount_uploader :picture, PictureUploader
  validate :picture_size
  before_create :default_case
  before_save :default_case



  private


  def picture_size
      if picture.size > 5.megabytes
          errors.add(:picture,"should be less than 5MB")
      end
  end

  def default_case
      if self.case_id.nil?
          self.case_id = "1"
      end
  end

end
