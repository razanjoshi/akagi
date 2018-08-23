class Renamemicropoststoposts < ActiveRecord::Migration[5.0]
  def self.up
    rename_table :microposts, :posts
  end

  def self.down
    rename_table :posts, :microposts
  end
end
