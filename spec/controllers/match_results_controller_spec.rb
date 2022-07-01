require "rails_helper"

describe MatchResultsController, :type => :controller do
    it "initializes a new match" do
      get :new

      assigns(:match_result).should_not be_nil
    end

    describe "create" do
      context "with valid params" do
        it "creates a match" do
          members = FactoryBot.create_list(:member, 6)
          first_player = members.first
          second_player = members.last
          match_result_attributes = {first_player: first_player.id, second_player: second_player.id}
          
          post :create, params: {match_result: match_result_attributes,winner: 'Draw'}

          MatchResult.last.should_not be_nil
        end
      end

      context "with valid params and update valid rank" do
        it "update valid rank when match draws with rank_diff 1" do
          #match_result_attributes = FactoryGirl.attributes_for(:match_result)
          members = FactoryBot.create_list(:member, 6)
          first_player = members.first
          second_player = members.last
          expt_result = {:winner=>"Draw", :prev_first_player_rank=>first_player.current_rank, :prev_second_player_rank=>second_player.current_rank}
          match_result_attributes = {first_player: first_player.id, second_player: second_player.id}
          
          post :create, params: {match_result: match_result_attributes,winner: 'Draw', p1: first_player.current_rank, p2: second_player.current_rank}

          MatchResult.last.should_not be_nil
          MatchResult.last.result == expt_result
        end
      end

      context "with valid params and update valid rank" do
        it "update valid rank when match draws with rank_diff > 1" do
          members = FactoryBot.create_list(:member, 6)
          first_player = members.first
          sixth_player = members.last
          rank_diff = sixth_player.current_rank - first_player.current_rank 
          half_distance_rank = rank_diff / 2
          expt_result = {:winner=>"Draw", :prev_first_player_rank=>first_player.current_rank, :prev_second_player_rank=>half_distance_rank}
          match_result_attributes = {first_player: first_player.id, second_player: sixth_player.id}
          
          post :create, params: {match_result: match_result_attributes,winner: 'Draw', p1: first_player.current_rank, p2: sixth_player.current_rank}

          MatchResult.last.should_not be_nil
          MatchResult.last.result == expt_result
        end
      end

      context "with valid params and update player ranks" do
        it "don't update valid rank when Higher rank wins" do
          members = FactoryBot.create_list(:member, 6)
          first_player = members.first
          sixth_player = members.last
          expt_result = {:winner=> 'First Player Won', :prev_first_player_rank=>first_player.current_rank, :prev_second_player_rank=>sixth_player.current_rank}
          match_result_attributes = {first_player: first_player.id, second_player: sixth_player.id}
          
          post :create, params: {match_result: match_result_attributes,winner: 'First Player Won', p1: first_player.current_rank, p2: sixth_player.current_rank}

          MatchResult.last.should_not be_nil
          MatchResult.last.result == expt_result
        end
      end

       context "with valid params and update player ranks" do
        it "update ranks for both players" do
          members = FactoryBot.create_list(:member, 10)
          first_player = members.first
          tenth_player = members.last
          rank_diff = tenth_player.current_rank - first_player.current_rank 
          half_distance_rank = rank_diff / 2
          expt_result = {:winner=>'Second Player Won', :prev_first_player_rank=>first_player.current_rank + 1, :prev_second_player_rank=>half_distance_rank}
          match_result_attributes = {first_player: first_player.id, second_player: tenth_player.id}
          
          post :create, params: {match_result: match_result_attributes,winner: 'Second Player Won', p1: first_player.current_rank, p2: tenth_player.current_rank}

          MatchResult.last.should_not be_nil
          MatchResult.last.result == expt_result
        end
      end

    end
end
