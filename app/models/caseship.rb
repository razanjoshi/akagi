class Caseship < ApplicationRecord
    belongs_to :father, class_name:"Case"
    belongs_to :sub_test1, class_name:"Case"
end
