class CreateItemLocales < ActiveRecord::Migration
  def change
    create_table :item_locales do |t|
      t.references :item
      t.references :locale
    end
    add_index :item_locales, :item_id
    add_index :item_locales, :locale_id
  end
end
