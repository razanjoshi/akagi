class CreateCaseships < ActiveRecord::Migration[5.0]
  def change
    create_table :caseships do |t|
      t.integer :father_id
      t.integer :sub_id

      t.timestamps
    end
    add_index :caseships,:father_id
    add_index :caseships,:sub_id
    add_index :caseships,[:father_id, :sub_id], unique:true
  end
end
