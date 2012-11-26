class CreateGameCodes < ActiveRecord::Migration
  def change
    create_table :game_codes do |t|
      t.string :code, :limit => 3
      t.float :bonus
      t.integer :days

      t.timestamps
    end
  end
end
