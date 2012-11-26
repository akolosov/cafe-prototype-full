class GroupLocale < ActiveRecord::Base
  belongs_to :group
  belongs_to :locale
end
