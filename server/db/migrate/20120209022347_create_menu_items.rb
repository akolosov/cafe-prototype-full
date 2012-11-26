class CreateMenuItems < ActiveRecord::Migration
  def change
    create_table :menu_items do |t|
      t.references :menu
      t.references :item
      t.float :cost, :null => false
    end
    add_index :menu_items, :menu_id
    add_index :menu_items, :item_id
  end
end
