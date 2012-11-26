class PropertyLocale < ActiveRecord::Base
  belongs_to :property
  belongs_to :locale
end
