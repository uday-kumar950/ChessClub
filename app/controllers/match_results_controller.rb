class MatchResultsController < ApplicationController

  def index
    @match_results = MatchResult.all
  end

  def new
    @match_result = MatchResult.new
    @members = Member.all
  end

  def create
    first_player = Member.find(match_result_params["first_player"])
    second_player = Member.find(match_result_params["second_player"])
    result = match_result_params["result"]

    @match_result = MatchResult.new(first_player: first_player, second_player: second_player, result:result)
    @match_result.result = {winner: params[:winner], prev_first_player_rank: first_player.id, prev_second_player_rank: second_player.id}
    @members = Member.all

     respond_to do |format|
		@match_result.transaction do
			if @match_result.save
				update_rank(first_player, second_player, params[:winner])
				update_total_games_played(first_player)
				update_total_games_played(second_player)
				format.html { redirect_to match_results_path, notice: "Ranks updated and match successfully recorded." }
				format.json { render :show, status: :created, location: @member }
			else
				format.html { render :new, status: :unprocessable_entity }
				format.json { render json: @match_result.errors, status: :unprocessable_entity }
			end
		end
    end
  end

  private

  def match_result_params
    params.require(:match_result).permit(:first_player, :second_player, :result)
  end

   def update_rank(first_player, second_player, result) 
   	lower_rank_player = (first_player.current_rank > second_player.current_rank ? first_player : second_player)
   	higher_rank_player = (first_player == lower_rank_player ? second_player : first_player)
   	rank_diff = lower_rank_player.current_rank - higher_rank_player.current_rank 
   	half_distance_rank = rank_diff / 2
    case result
    when 'Draw'
      if rank_diff > 1
      	upgrade_rank(lower_rank_player, 1)
      end
    when 'First Player Won'
    	if higher_rank_player == second_player
    		downgrade_rank(second_player, half_distance_rank)
    		upgrade_rank(first_player, half_distance_rank)
    	end
    	
    when 'Second Player Won'
    	if higher_rank_player == first_player
    		downgrade_rank(first_player, half_distance_rank)
    		upgrade_rank(second_player, half_distance_rank)
    	end
    	
    end
  end

  def upgrade_rank(player, half_distance_rank)
  	player_new_rank = player.current_rank - half_distance_rank
    lower_rank_members = Member.where("current_rank >= ?", player_new_rank) 
    lower_rank_members.each do |m|
    	m.update_attribute(:current_rank, m.current_rank + 1)
    end
    player.update(:current_rank => player_new_rank)
  end

  def downgrade_rank(player, half_distance_rank)
    lower_rank_member = Member.find_by_current_rank(player.current_rank + 1)
    lower_rank_member.update_attribute(:current_rank, lower_rank_member.current_rank - 1) if lower_rank_member.present?
    player.update(:current_rank => player.current_rank + 1)
  end

  def update_total_games_played(player)
  	player.update_attribute(:no_of_played_games, player.no_of_played_games + 1)
  end

end
