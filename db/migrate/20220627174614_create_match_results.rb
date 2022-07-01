class CreateMatchResults < ActiveRecord::Migration[7.0]
  def change
    create_table :match_results do |t|
      t.integer :first_player, null: false
      t.integer :second_player, null: false
      t.text :result

      t.timestamps
    end
  end
end
