class CreateItemProperties < ActiveRecord::Migration
  def change
    create_table :item_properties do |t|
      t.references :item
      t.references :property
      t.string     :value, :null => false
    end
    add_index :item_properties, :item_id
    add_index :item_properties, :property_id
  end
end
