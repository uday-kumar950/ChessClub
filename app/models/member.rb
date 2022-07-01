class Member < ApplicationRecord

	has_many :match_results, dependent: :destroy

	validates_presence_of :first_name, :last_name, :email, :dob, :no_of_played_games

	validates_uniqueness_of :email, :current_rank

	attr_reader :fullnames_with_rank

	def self.get_last_rank
		last_member = Member.last
		return (last_member.present? ? (last_member.current_rank + 1) : 1)
	end

	def fullnames_with_rank
  		"#{first_name} #{last_name} (Rank: #{current_rank})"
	end

end
