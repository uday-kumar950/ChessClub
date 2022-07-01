FactoryGirl.define do
  sequence :email do |n|
    "email#{n}@gmail.com"
  end

  sequence :current_rank do |n|
    n
  end

  factory :member do
    first_name { Faker::Name.name }
    last_name { Faker::Lorem.words(4).first.capitalize }
    email 
    dob   "20/01/1996"
    no_of_played_games 0
    current_rank 
  end
end

FactoryBot.define do
  sequence :email do |n|
    "email#{n}@gmail.com"
  end

  sequence :current_rank do |n|
    n
  end

  factory :member do
    first_name { Faker::Name.name }
    last_name { Faker::Lorem.words(4).first.capitalize }
    email 
    dob   {"20/01/1996"}
    no_of_played_games {0}
    current_rank 
  end
end

