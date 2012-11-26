class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.references :group_locales
      t.string :photo, :null => false
    end
  end
end
