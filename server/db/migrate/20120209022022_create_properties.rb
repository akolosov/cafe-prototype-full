class CreateProperties < ActiveRecord::Migration
  def change
    create_table :properties do |t|
      t.references :property_locales
    end
  end
end
