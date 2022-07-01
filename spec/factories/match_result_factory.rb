FactoryGirl.define do
  factory :match_result do
    first_player_obj = create(:member)
    second_player_obj = create(:member)
  #  puts "@@@@@@#{first_player_obj}@@@@@@@@#{second_player_obj}@@@@@@@@@@@@@"
    first_player first_player_obj
    second_player second_player_obj
    result {}.to_s
  end
end


#params.require(:match_result).permit(:first_player, :second_player, :result)