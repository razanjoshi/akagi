json.post do
  json.array! @posts do |post|
    json.(post, :id, :content)
  end
end
