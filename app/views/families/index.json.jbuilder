json.array!(@families) do |family|
  json.extract! family, :id, :family_name, :parent_first_name, :email, :phone, :active
  json.url family_url(family, format: :json)
end
