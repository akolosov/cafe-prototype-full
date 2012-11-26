class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.references :group
      t.references :item_locales
      t.string     :photo, :null => false
    end
    add_index :items, :group_id
  end
end
