class CreateUserProviders < ActiveRecord::Migration
  def self.up
    create_table :user_providers do |t|
      t.integer :user_id, :null => false
      t.string :provider, :uid, :null => false
    end
  end

  def self.down
    drop_table :user_providers
  end
end
