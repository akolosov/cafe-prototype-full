class CreateMenuLocales < ActiveRecord::Migration
  def change
    create_table :menu_locales do |t|
      t.references :menu
      t.references :locale
    end
    add_index :menu_locales, :menu_id
    add_index :menu_locales, :locale_id
  end
end
