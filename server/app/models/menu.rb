class Menu < ActiveRecord::Base
  has_many :menu_items, :dependent => :destroy
  has_many :menu_locales, :dependent => :destroy

  def locale(locale = nil)
     if (!locale) then
      locale = Cafe::Application.config.default_locale
     end

     menu_locales.each { |menu_locale|
      if (menu_locale.locale.locale == locale) then
        return menu_locale.locale.id
      end
     }
  end

  def name(locale = nil)
  	 if (!locale) then
  	 	locale = Cafe::Application.config.default_locale
  	 end

  	 menu_locales.each { |menu_locale|
  	 	if (menu_locale.locale.locale == locale) then
  	 		return menu_locale.locale.name
  	 	end
  	 }

  end

  def description(locale = nil)
  	 if (!locale) then
  	 	locale = Cafe::Application.config.default_locale
  	 end

  	 menu_locales.each { |menu_locale|
  	 	if (menu_locale.locale.locale == locale) then
  	 		return menu_locale.locale.description
  	 	end
  	 }
  end

end
