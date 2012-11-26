class Property < ActiveRecord::Base
  has_many :item_properties, :dependent => :destroy

  has_many :property_locales, :dependent => :destroy

  def locale(locale = nil)
     if (!locale) then
      locale = Cafe::Application.config.default_locale
     end

     property_locales.each { |property_locale|
      if (property_locale.locale.locale == locale) then
        return property_locale.locale.id
      end
     }
  end

  def name(locale = nil)
  	 if (!locale) then
  	 	locale = Cafe::Application.config.default_locale
  	 end

  	 property_locales.each { |property_locale|
  	 	if (property_locale.locale.locale == locale) then
  	 		return property_locale.locale.name
  	 	end
  	 }

  end

  def description(locale = nil)
  	 if (!locale) then
  	 	locale = Cafe::Application.config.default_locale
  	 end

  	 property_locales.each { |property_locale|
  	 	if (property_locale.locale.locale == locale) then
  	 		return property_locale.locale.description
  	 	end
  	 }
  end

end
