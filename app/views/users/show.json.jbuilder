json.extract! @user, :id, :name, :email, :created_at, :updated_at, microposts
json.extract! @micropost, :id :content, :user_id, :created_at, :updated_at
