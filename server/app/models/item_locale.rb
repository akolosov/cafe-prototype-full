class ItemLocale < ActiveRecord::Base
  belongs_to :item
  belongs_to :locale
end
