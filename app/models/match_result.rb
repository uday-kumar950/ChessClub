class MatchResult < ApplicationRecord
  belongs_to :first_player, :class_name => 'Member', :foreign_key => 'first_player'
  belongs_to :second_player, :class_name => 'Member', :foreign_key => 'second_player'
  serialize :result, Hash

  validates_presence_of :first_player, :second_player
  validate :players_not_same

  def players_not_same
  	is_invalid = (first_player == second_player)
  	errors.add(:first_player, "First Player and Second Player should not be same!!") if is_invalid
  end
end
