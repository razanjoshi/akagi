class AddLevelToCases < ActiveRecord::Migration[5.0]
  def change
    add_column :cases, :level, :integer, default:1
    add_column :cases, :parent_id, :integer, index:true
    rename_column :cases, :body, :content
  end
end
