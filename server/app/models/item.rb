class Item < ActiveRecord::Base
  has_many :item_properties, :dependent => :destroy

  has_many :menu_items, :dependent => :destroy

  has_many :item_locales, :dependent => :destroy

  belongs_to :group

  def locale(locale = nil)
     if (!locale) then
      locale = Cafe::Application.config.default_locale
     end

     item_locales.each { |item_locale|
      if (item_locale.locale.locale == locale) then
        return item_locale.locale.id
      end
     }
  end

  def name(locale = nil)
  	 if (!locale) then
  	 	locale = Cafe::Application.config.default_locale
  	 end

  	 item_locales.each { |item_locale|
  	 	if (item_locale.locale.locale == locale) then
  	 		return item_locale.locale.name
  	 	end
  	 }

  end

  def description(locale = nil)
  	 if (!locale) then
  	 	locale = Cafe::Application.config.default_locale
  	 end

  	 item_locales.each { |item_locale|
  	 	if (item_locale.locale.locale == locale) then
  	 		return item_locale.locale.description
  	 	end
  	 }
  end

end
