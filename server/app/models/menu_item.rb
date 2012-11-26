class MenuItem < ActiveRecord::Base
  belongs_to :menu
  belongs_to :item

  has_many :order_items

end
