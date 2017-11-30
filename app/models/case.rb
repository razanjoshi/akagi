class Case < ApplicationRecord

  #self.per_page = 20

  TYPES_OF_SELF    = 1
  TYPES_OF_ANOY    = 2
  TYPES_OF_NONANOY   = 3

  has_many :subcases, class_name: "Case", foreign_key: "parent_id"
  belongs_to :parent, class_name: "Case", optional: true

  has_many :photos, as: :photoable

  accepts_nested_attributes_for :photos, reject_if: proc{ |photo|
              photo['image'].blank?  }


  has_many :posts, dependent: :destroy
  belongs_to :user, optional: true

  default_scope -> { order(updated_at: :desc) }

  scope :level, -> (level){ where(level: level) }

  scope :bbs, -> { where(types: [2,3]) }

  scope :by_types, -> (types){ where(types: types) }

  before_save :set_level

  acts_as_taggable # Alias for acts_as_taggable_on :tags

  def set_level
    if self.parent
      self.level = self.parent.level + 1
    else
      self.level = 1
    end
  end

  def get_family
    family = [self]
    child = self
    (self.level-1).times do
      child = child.parent
      family.unshift child
    end
    family
  end

  def get_nickname
    self.types == Case::TYPES_OF_ANOY ? self.nickname : self.user.decode_nickname
  end

  def get_avatar
    if self.types == Case::TYPES_OF_NONANOY and self.user.avatar.present?
      self.user.avatar
    elsif Settings.nicknames.include? self.nickname
      self.nickname + '.jpg'
    else
      Settings.nicknames.sample + '.jpg'
    end
  end


  def logo
    if self.photos.empty?
      return 'http://oes1t3t81.bkt.clouddn.com//blog/1511962137717.JPG'
    else
      self.photos.first.image
    end
  end


end
