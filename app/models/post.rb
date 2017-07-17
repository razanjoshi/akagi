class Post < ApplicationRecord

  belongs_to :user
  belongs_to :case

  has_many :values, class_name: "Post", foreign_key: "key_id"
  belongs_to :key, class_name: "Post", optional: true


  default_scope -> { order(created_at: :desc) }
  #validates :user_id, presence:true
  validates :content, presence:true
  #mount_uploader :picture, PictureUploader
  accepts_nested_attributes_for :values


  before_create :default_case
  before_save :default_case



  private


  def default_case
    if self.case_id.nil?
        self.case_id = 1
    end
  end

end
