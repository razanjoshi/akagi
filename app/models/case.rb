class Case < ApplicationRecord
    belongs_to :user
    has_one :active_caseships, class_name: "Caseship",foreign_key:"sub_id",dependent: :destroy
    has_one :father_case, through: :active_caseships, source: :father
    has_many :passive_caseships, class_name: "Caseship", foreign_key:"father_id",dependent: :destroy
    has_many :sub_cases, through: :passive_caseships, source: :sub_test2



    has_many :microposts,dependent: :destroy
    default_scope -> { order(updated_at: :desc) }
    validates :user_id, presence:true
    #mount_uploader :picture, PictureUploader
    #validate :picture_size

    def father(other_case_id)
        create_active_caseships(father_id: other_case_id)
    end

    def feed
        sub_cases_ids = "SELECT sub_id FROM caseships WHERE father_id = :case_id"
        Micropost.where("case_id IN (#{sub_cases_ids}) OR case_id = :case_id",case_id:id)
    end

end
