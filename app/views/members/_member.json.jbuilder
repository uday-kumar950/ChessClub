json.extract! member, :id, :first_name, :last_name, :email, :dob, :no_of_played_games, :current_rank, :created_at, :updated_at
json.url member_url(member, format: :json)
