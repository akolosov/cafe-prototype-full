class CreateUserProperties < ActiveRecord::Migration
  def change
    create_table :user_properties do |t|
      t.references :user
      t.string :name, :null => false
      t.string :phone, :null => false
      t.string :address
      t.date :birthday
    end
    add_index :user_properties, :user_id
  end
end
