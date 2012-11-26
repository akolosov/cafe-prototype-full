class CreateMenus < ActiveRecord::Migration
  def change
    create_table :menus do |t|
      t.references :menu_locales
      t.date :startdate
      t.date :enddate
    end
  end
end
