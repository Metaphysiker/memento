json.extract! person, :id, :firstname, :lastname, :email, :phone, :philosophie_id, :login, :created_at, :updated_at
json.url person_url(person, format: :json)
