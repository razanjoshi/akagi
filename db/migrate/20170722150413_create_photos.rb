class CreatePhotos < ActiveRecord::Migration[5.0]
  def change
    create_table :photos do |t|
      t.string   :title,          limit: 20
      t.string   :image,          limit: 150
      t.integer  :photoable_id, index:true
      t.string   :photoable_type

      t.timestamps

    end
  end
end
