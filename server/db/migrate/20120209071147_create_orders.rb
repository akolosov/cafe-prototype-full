class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.references :user
      t.string  :session
      t.string  :name
      t.string  :phone
      t.string  :address
      t.string  :additions
      t.string  :status
      t.boolean :checked, :default => false
      t.boolean :closed, :default => false

      t.timestamps
    end
    add_index :orders, :user_id
  end
end
