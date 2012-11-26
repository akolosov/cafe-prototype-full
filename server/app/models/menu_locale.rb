class MenuLocale < ActiveRecord::Base
  belongs_to :menu
  belongs_to :locale
end
