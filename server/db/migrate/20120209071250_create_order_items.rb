class CreateOrderItems < ActiveRecord::Migration
  def change
    create_table :order_items do |t|
      t.references :order
      t.references :menu_item
      t.integer :count, :null => false
    end
    add_index :order_items, :order_id
    add_index :order_items, :menu_item_id
  end
end
