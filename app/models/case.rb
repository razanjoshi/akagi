class Case < ApplicationRecord

  #self.per_page = 20

  has_many :subcases, class_name: "Case", foreign_key: "parent_id"
  belongs_to :parent, class_name: "Case", optional: true

  has_many :posts, dependent: :destroy

  default_scope -> { order(updated_at: :desc) }

  scope :level, -> (level){ where(level: level) }

  before_save :set_level

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



end
