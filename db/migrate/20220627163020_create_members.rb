class CreateMembers < ActiveRecord::Migration[7.0]
  def change
    create_table :members do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.date :dob
      t.integer :no_of_played_games
      t.integer :current_rank

      t.timestamps
    end
  end
end
