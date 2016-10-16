class AddWeiboToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :weibo, :string
  end
end
