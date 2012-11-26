class CreateLocales < ActiveRecord::Migration
  def change
    create_table :locales do |t|
      t.string :name, :null => false
      t.text :description
      t.string :locale, :null => false
    end
  end
end
