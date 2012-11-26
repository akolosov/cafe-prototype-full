class CreateUserAccounts < ActiveRecord::Migration
  def change
    create_table :user_accounts do |t|
      t.references :user
      t.string :code, :limit => 3
      t.float :bonus
      t.boolean :used, :default => false
      t.date :expired_at

      t.timestamps
    end
    add_index :user_accounts, :user_id
  end
end
