json.array!(@languages) do |language|
  json.extract! language, :id, :slug
  json.url language_url(language, format: :json)
end
