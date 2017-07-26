class AddNicknameToPosts < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :nickname, :string, limit: 50
    add_column :cases, :nickname, :string, limit: 50
    add_column :posts, :types, :integer, default: 1
    add_column :cases, :types, :integer, default: 1
  end
end
