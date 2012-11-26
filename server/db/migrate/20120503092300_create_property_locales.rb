class CreatePropertyLocales < ActiveRecord::Migration
  def change
    create_table :property_locales do |t|
      t.references :property
      t.references :locale
    end
    add_index :property_locales, :property_id
    add_index :property_locales, :locale_id
  end
end
