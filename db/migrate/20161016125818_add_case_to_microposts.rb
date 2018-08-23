class AddCaseToMicroposts < ActiveRecord::Migration[5.0]
  def change
    add_reference :microposts, :case, index:true, foreign_key: true
  end
end
