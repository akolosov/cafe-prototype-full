class CreateGroupLocales < ActiveRecord::Migration
  def change
    create_table :group_locales do |t|
      t.references :group
      t.references :locale
    end
    add_index :group_locales, :group_id
    add_index :group_locales, :locale_id
  end
end
