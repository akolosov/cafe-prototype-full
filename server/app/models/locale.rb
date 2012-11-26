class Locale < ActiveRecord::Base
  attr_accessible :description, :locale, :name

  belongs_to :item_locale

  belongs_to :group_locale

  belongs_to :property_locale

  belongs_to :menu_locale

end
