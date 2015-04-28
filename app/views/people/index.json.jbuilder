json.array!(@people) do |person|
  json.extract! person, :id, :name, :origin_name, :sex, :birthday, :avatar
  json.url person_url(person, format: :json)
end
