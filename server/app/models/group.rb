class Group < ActiveRecord::Base
  has_many :items, :dependent => :destroy
  has_many :group_locales, :dependent => :destroy

  def locale(locale = nil)
     if (!locale) then
      locale = Cafe::Application.config.default_locale
     end

     group_locales.each { |group_locale|
      if (group_locale.locale.locale == locale) then
        return group_locale.locale.id
      end
     }
  end

  def name(locale = nil)
  	 if (!locale) then
  	 	locale = Cafe::Application.config.default_locale
  	 end

  	 group_locales.each { |group_locale|
  	 	if (group_locale.locale.locale == locale) then
  	 		return group_locale.locale.name
  	 	end
  	 }
  end

  def description(locale = nil)
  	 if (!locale) then
  	 	locale = Cafe::Application.config.default_locale
  	 end

  	 group_locales.each { |group_locale|
  	 	if (group_locale.locale.locale == locale) then
  	 		return group_locale.locale.description
  	 	end
  	 }
  end

end
