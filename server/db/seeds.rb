# coding: UTF-8
# encoding: UTF-8
#
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

admin = User.create  :email => 'admin@test.com', :password => 'admin', :password_confirmation => 'admin'
admin.roles = 'admin'
admin.save
UserProperty.new(:user => admin, :name => 'Admin Admin', :phone => '322223',  :address => 'hell', :birthday => (Random.rand(50)+1).year.ago.strftime("%Y-%m-%d")).save()

user = User.create  :email => 'user@test.com', :password => 'user', :password_confirmation => 'user'
user.roles = 'user'
user.save
UserProperty.new(:user => user, :name => 'User User', :phone => '322223',  :address => 'hell', :birthday => (Random.rand(50)+1).year.ago.strftime("%Y-%m-%d")).save()

test = User.create  :email => 'test@test.com', :password => 'test', :password_confirmation => 'test'
test.roles = 'user'
test.save
UserProperty.new(:user => test, :name => 'Test Test', :phone => '322223',  :address => 'hell', :birthday => (Random.rand(50)+1).year.ago.strftime("%Y-%m-%d")).save()

anonim = User.create  :id => -1, :email => 'anonim@test.com', :password => 'anonim', :password_confirmation => 'anonim'
anonim.roles = 'guest'
anonim.save
UserProperty.new(:user => anonim, :name => 'Anonim Anonim', :phone => '322223',  :address => 'hell', :birthday => (Random.rand(50)+1).year.ago.strftime("%Y-%m-%d")).save()

group = Group.new(:photo => "menu/beverages/1.jpg")
group.group_locales = []
group.group_locales << GroupLocale.new(:locale => Locale.new(:name => "Напитки", :description => "Это напитки", :locale => "ru"), :group => group)
group.group_locales << GroupLocale.new(:locale => Locale.new(:name => "Beverages", :description => "This is beverages", :locale => "en"), :group => group)
group.group_locales << GroupLocale.new(:locale => Locale.new(:name => "Bebidas", :description => "Una bebidas", :locale => "es"), :group => group)
group.save

group = Group.new(:photo => "menu/salads/1.jpg")
group.group_locales = []
group.group_locales << GroupLocale.new(:locale => Locale.new(:name => "Салаты", :description => "Это салаты", :locale => "ru"), :group => group)
group.group_locales << GroupLocale.new(:locale => Locale.new(:name => "Salads", :description => "This is salads", :locale => "en"), :group => group)
group.group_locales << GroupLocale.new(:locale => Locale.new(:name => "Ensaladas", :description => "Una ensaladas", :locale => "es"), :group => group)
group.save

group = Group.new(:photo => "menu/seconds/1.jpg")
group.group_locales = []
group.group_locales << GroupLocale.new(:locale => Locale.new(:name => "Вторые блюда", :description => "Это вторые блюда", :locale => "ru"), :group => group)
group.group_locales << GroupLocale.new(:locale => Locale.new(:name => "Second cources", :description => "This is second cources", :locale => "en"), :group => group)
group.group_locales << GroupLocale.new(:locale => Locale.new(:name => "Segundos platos", :description => "Una segundos platos", :locale => "es"), :group => group)
group.save

group = Group.new(:photo => "menu/snacks/1.jpg")
group.group_locales = []
group.group_locales << GroupLocale.new(:locale => Locale.new(:name => "Снэки", :description => "Это снэки", :locale => "ru"), :group => group)
group.group_locales << GroupLocale.new(:locale => Locale.new(:name => "Snacks", :description => "This is snacks", :locale => "en"), :group => group)
group.group_locales << GroupLocale.new(:locale => Locale.new(:name => "Snacks", :description => "This is snacks", :locale => "es"), :group => group)
group.save

group = Group.new(:photo => "menu/soups/1.jpg")
group.group_locales = []
group.group_locales << GroupLocale.new(:locale => Locale.new(:name => "Супы", :description => "Это супы", :locale => "ru"), :group => group)
group.group_locales << GroupLocale.new(:locale => Locale.new(:name => "Soups", :description => "This is soups", :locale => "en"), :group => group)
group.group_locales << GroupLocale.new(:locale => Locale.new(:name => "Sopas", :description => "Una sopas", :locale => "es"), :group => group)
group.save

10.times do |i|
 	property = Property.new
 	property.property_locales = []
	property.property_locales << PropertyLocale.new(:locale => Locale.new(:name => "Свойство ##{i.to_s}", :description => "Это свойство блюда", :locale => "ru"), :property => property)
	property.property_locales << PropertyLocale.new(:locale => Locale.new(:name => "Property ##{i.to_s}", :description => "This is item property", :locale => "en"), :property => property)
	property.property_locales << PropertyLocale.new(:locale => Locale.new(:name => "Propiedad ##{i.to_s}", :description => "Una propiedad", :locale => "es"), :property => property)
	property.save
end

item = Item.new(:photo => "menu/beverages/1.jpg", :group_id => 1)
item.item_locales = []
item.item_locales << ItemLocale.new(:locale => Locale.new(:name => "Чай", :description => "Черный чай", :locale => "ru"), :item => item)
item.item_locales << ItemLocale.new(:locale => Locale.new(:name => "Tea", :description => "Black tea", :locale => "en"), :item => item)
item.item_locales << ItemLocale.new(:locale => Locale.new(:name => "El té", :description => "El té negro", :locale => "es"), :item => item)
item.save

item = Item.new(:photo => "menu/beverages/2.jpg", :group_id => 1)
item.item_locales = []
item.item_locales << ItemLocale.new(:locale => Locale.new(:name => "Кофе", :description => "Это Кофе", :locale => "ru"), :item => item)
item.item_locales << ItemLocale.new(:locale => Locale.new(:name => "Cafe", :description => "This is cafe", :locale => "en"), :item => item)
item.item_locales << ItemLocale.new(:locale => Locale.new(:name => "Café", :description => "Una Café", :locale => "es"), :item => item)
item.save

item = Item.new(:photo => "menu/beverages/3.jpg", :group_id => 1)
item.item_locales = []
item.item_locales << ItemLocale.new(:locale => Locale.new(:name => "Морс", :description => "Клюквенный морс", :locale => "ru"), :item => item)
item.item_locales << ItemLocale.new(:locale => Locale.new(:name => "Juice", :description => "Cranberry juice", :locale => "en"), :item => item)
item.item_locales << ItemLocale.new(:locale => Locale.new(:name => "De jugo", :description => "De jugo de arándano", :locale => "es"), :item => item)
item.save

item = Item.new(:photo => "menu/salads/1.jpg", :group_id => 2)
item.item_locales = []
item.item_locales << ItemLocale.new(:locale => Locale.new(:name => "Сельдь под шубой", :description => "Сельдь под шубой", :locale => "ru"), :item => item)
item.item_locales << ItemLocale.new(:locale => Locale.new(:name => "Herring salad", :description => "Herring salad", :locale => "en"), :item => item)
item.item_locales << ItemLocale.new(:locale => Locale.new(:name => "Ensalada de arenque", :description => "Ensalada de arenque", :locale => "es"), :item => item)
item.save

item = Item.new(:photo => "menu/salads/2.jpg", :group_id => 2)
item.item_locales = []
item.item_locales << ItemLocale.new(:locale => Locale.new(:name => "Греческий салат", :description => "Греческий салат", :locale => "ru"), :item => item)
item.item_locales << ItemLocale.new(:locale => Locale.new(:name => "Greek salad", :description => "Greek salad", :locale => "en"), :item => item)
item.item_locales << ItemLocale.new(:locale => Locale.new(:name => "Ensalada Griega", :description => "Ensalada Griega", :locale => "es"), :item => item)
item.save

item = Item.new(:photo => "menu/salads/3.jpg", :group_id => 2)
item.item_locales = []
item.item_locales << ItemLocale.new(:locale => Locale.new(:name => "Крабовый салат", :description => "Крабовый салат", :locale => "ru"), :item => item)
item.item_locales << ItemLocale.new(:locale => Locale.new(:name => "Crab salad", :description => "Crab salad", :locale => "en"), :item => item)
item.item_locales << ItemLocale.new(:locale => Locale.new(:name => "Ensalada de cangrejo", :description => "Ensalada de cangrejo", :locale => "es"), :item => item)
item.save

item = Item.new(:photo => "menu/salads/4.jpg", :group_id => 2)
item.item_locales = []
item.item_locales << ItemLocale.new(:locale => Locale.new(:name => "Салат оливье", :description => "Салат оливье", :locale => "ru"), :item => item)
item.item_locales << ItemLocale.new(:locale => Locale.new(:name => "Russian salad", :description => "Russian salad", :locale => "en"), :item => item)
item.item_locales << ItemLocale.new(:locale => Locale.new(:name => "Ensaladilla rusa", :description => "Ensaladilla rusa", :locale => "es"), :item => item)
item.save

item = Item.new(:photo => "menu/salads/5.jpg", :group_id => 2)
item.item_locales = []
item.item_locales << ItemLocale.new(:locale => Locale.new(:name => "Салат с ветчиной и грибами", :description => "Салат с ветчиной и грибами", :locale => "ru"), :item => item)
item.item_locales << ItemLocale.new(:locale => Locale.new(:name => "Mushroom and ham salad", :description => "Mushroom and ham salad", :locale => "en"), :item => item)
item.item_locales << ItemLocale.new(:locale => Locale.new(:name => "Ensalada con jamón y champiñones", :description => "Ensalada con jamón y champiñones", :locale => "es"), :item => item)
item.save

item = Item.new(:photo => "menu/seconds/1.jpg", :group_id => 3)
item.item_locales = []
item.item_locales << ItemLocale.new(:locale => Locale.new(:name => "Говядина с грибами", :description => "Говядина с грибами", :locale => "ru"), :item => item)
item.item_locales << ItemLocale.new(:locale => Locale.new(:name => "Beef with mushrooms", :description => "Beef with mushrooms", :locale => "en"), :item => item)
item.item_locales << ItemLocale.new(:locale => Locale.new(:name => "Ternera con setas", :description => "Ternera con setas", :locale => "es"), :item => item)
item.save

item = Item.new(:photo => "menu/seconds/2.jpg", :group_id => 3)
item.item_locales = []
item.item_locales << ItemLocale.new(:locale => Locale.new(:name => "Греча", :description => "Гречка", :locale => "ru"), :item => item)
item.item_locales << ItemLocale.new(:locale => Locale.new(:name => "Buckwheat", :description => "Buckwheat", :locale => "en"), :item => item)
item.item_locales << ItemLocale.new(:locale => Locale.new(:name => "Alforfón", :description => "Alforfón", :locale => "es"), :item => item)
item.save

item = Item.new(:photo => "menu/seconds/3.jpg", :group_id => 3)
item.item_locales = []
item.item_locales << ItemLocale.new(:locale => Locale.new(:name => "Отбивная с сыром", :description => "Отбивная с сыром", :locale => "ru"), :item => item)
item.item_locales << ItemLocale.new(:locale => Locale.new(:name => "Chop steak with cheese", :description => "Chop steak with cheese", :locale => "en"), :item => item)
item.item_locales << ItemLocale.new(:locale => Locale.new(:name => "Сarne y queso", :description => "Сarne y queso", :locale => "es"), :item => item)
item.save

item = Item.new(:photo => "menu/seconds/4.jpg", :group_id => 3)
item.item_locales = []
item.item_locales << ItemLocale.new(:locale => Locale.new(:name => "Горбуша с сыром", :description => "Горбуша с сыром", :locale => "ru"), :item => item)
item.item_locales << ItemLocale.new(:locale => Locale.new(:name => "Pink salmon with cheese", :description => "Pink salmon with cheese", :locale => "en"), :item => item)
item.item_locales << ItemLocale.new(:locale => Locale.new(:name => "Salmón rosado y queso", :description => "Salmón rosado y queso", :locale => "es"), :item => item)
item.save

item = Item.new(:photo => "menu/seconds/5.jpg", :group_id => 3)
item.item_locales = []
item.item_locales << ItemLocale.new(:locale => Locale.new(:name => "Картофельное пюре", :description => "Картофельное пюре", :locale => "ru"), :item => item)
item.item_locales << ItemLocale.new(:locale => Locale.new(:name => "Potatoo puree", :description => "Potatoo puree", :locale => "en"), :item => item)
item.item_locales << ItemLocale.new(:locale => Locale.new(:name => "Puré de papas", :description => "Рuré de papas", :locale => "es"), :item => item)
item.save

item = Item.new(:photo => "menu/seconds/6.jpg", :group_id => 3)
item.item_locales = []
item.item_locales << ItemLocale.new(:locale => Locale.new(:name => "Цветная капуста", :description => "Цветная капуста", :locale => "ru"), :item => item)
item.item_locales << ItemLocale.new(:locale => Locale.new(:name => "Stewed cauliflower", :description => "Stewed cauliflower", :locale => "en"), :item => item)
item.item_locales << ItemLocale.new(:locale => Locale.new(:name => "Сoliflor", :description => "Сoliflor", :locale => "es"), :item => item)
item.save

item = Item.new(:photo => "menu/seconds/7.jpg", :group_id => 3)
item.item_locales = []
item.item_locales << ItemLocale.new(:locale => Locale.new(:name => "Свинина с овощами", :description => "Свинина с овощами", :locale => "ru"), :item => item)
item.item_locales << ItemLocale.new(:locale => Locale.new(:name => "Stewed pork", :description => "Stewed pork", :locale => "en"), :item => item)
item.item_locales << ItemLocale.new(:locale => Locale.new(:name => "Carne de cerdo con verduras", :description => "Carne de cerdo con verduras", :locale => "es"), :item => item)
item.save

item = Item.new(:photo => "menu/seconds/8.jpg", :group_id => 3)
item.item_locales = []
item.item_locales << ItemLocale.new(:locale => Locale.new(:name => "Жаркое по венгерски", :description => "Жаркое по венгерски", :locale => "ru"), :item => item)
item.item_locales << ItemLocale.new(:locale => Locale.new(:name => "Stewed vegetables", :description => "Stewed vegetables", :locale => "en"), :item => item)
item.item_locales << ItemLocale.new(:locale => Locale.new(:name => "Caliente en el húngaro", :description => "Caliente en el húngaro", :locale => "es"), :item => item)
item.save

item = Item.new(:photo => "menu/seconds/9.jpg", :group_id => 3)
item.item_locales = []
item.item_locales << ItemLocale.new(:locale => Locale.new(:name => "Говядина, тушенная с овощами", :description => "Говядина, тушенная с овощами", :locale => "ru"), :item => item)
item.item_locales << ItemLocale.new(:locale => Locale.new(:name => "Stewed beef with vegetables", :description => "Stewed beef with vegetables", :locale => "en"), :item => item)
item.item_locales << ItemLocale.new(:locale => Locale.new(:name => "Estofado de carne con verduras", :description => "Estofado de carne con verduras", :locale => "es"), :item => item)
item.save

item = Item.new(:photo => "menu/seconds/10.jpg", :group_id => 3)
item.item_locales = []
item.item_locales << ItemLocale.new(:locale => Locale.new(:name => "Котлета домашняя", :description => "Котлета домашняя", :locale => "ru"), :item => item)
item.item_locales << ItemLocale.new(:locale => Locale.new(:name => "Beef cutlet", :description => "Beef cutlet", :locale => "en"), :item => item)
item.item_locales << ItemLocale.new(:locale => Locale.new(:name => "Pollo en casa", :description => "Pollo en casa", :locale => "es"), :item => item)
item.save

item = Item.new(:photo => "menu/seconds/11.jpg", :group_id => 3)
item.item_locales = []
item.item_locales << ItemLocale.new(:locale => Locale.new(:name => "Курица с сыром и помидорами", :description => "Курица с сыром и помидорами", :locale => "ru"), :item => item)
item.item_locales << ItemLocale.new(:locale => Locale.new(:name => "Chicken with cheese and tomatto", :description => "Chicken with cheese and tomatto", :locale => "en"), :item => item)
item.item_locales << ItemLocale.new(:locale => Locale.new(:name => "Pollo con queso y tomate", :description => "Pollo con queso y tomate", :locale => "es"), :item => item)
item.save

item = Item.new(:photo => "menu/seconds/12.jpg", :group_id => 3)
item.item_locales = []
item.item_locales << ItemLocale.new(:locale => Locale.new(:name => "Рис с овощами", :description => "Рис с овощами", :locale => "ru"), :item => item)
item.item_locales << ItemLocale.new(:locale => Locale.new(:name => "Rice with vegetables", :description => "Rice with vegetables", :locale => "en"), :item => item)
item.item_locales << ItemLocale.new(:locale => Locale.new(:name => "Arroz con verduras", :description => "Arroz con verduras", :locale => "es"), :item => item)
item.save

item = Item.new(:photo => "menu/snacks/1.jpg", :group_id => 4)
item.item_locales = []
item.item_locales << ItemLocale.new(:locale => Locale.new(:name => "Шаурма с курицей", :description => "Шаурма с курицей", :locale => "ru"), :item => item)
item.item_locales << ItemLocale.new(:locale => Locale.new(:name => "Chicken wrap", :description => "Chicken wrap", :locale => "en"), :item => item)
item.item_locales << ItemLocale.new(:locale => Locale.new(:name => "Pollo shawarma", :description => "Pollo shawarma", :locale => "es"), :item => item)
item.save

item = Item.new(:photo => "menu/snacks/2.jpg", :group_id => 4)
item.item_locales = []
item.item_locales << ItemLocale.new(:locale => Locale.new(:name => "Шаурма со свининой", :description => "Шаурма со свининой", :locale => "ru"), :item => item)
item.item_locales << ItemLocale.new(:locale => Locale.new(:name => "Pork wrap", :description => "Pork wrap", :locale => "en"), :item => item)
item.item_locales << ItemLocale.new(:locale => Locale.new(:name => "Shawarma carne de cerdo", :description => "Shawarma carne de cerdo", :locale => "es"), :item => item)
item.save

item = Item.new(:photo => "menu/snacks/3.jpg", :group_id => 4)
item.item_locales = []
item.item_locales << ItemLocale.new(:locale => Locale.new(:name => "Булочка", :description => "Булочка", :locale => "ru"), :item => item)
item.item_locales << ItemLocale.new(:locale => Locale.new(:name => "Cookie", :description => "Cookie", :locale => "en"), :item => item)
item.item_locales << ItemLocale.new(:locale => Locale.new(:name => "Rodar", :description => "Rodar", :locale => "es"), :item => item)
item.save

item = Item.new(:photo => "menu/snacks/4.jpg", :group_id => 4)
item.item_locales = []
item.item_locales << ItemLocale.new(:locale => Locale.new(:name => "Завтрак с бургером", :description => "Завтрак с бургером", :locale => "ru"), :item => item)
item.item_locales << ItemLocale.new(:locale => Locale.new(:name => "Burger breakfast", :description => "Burger breakfast", :locale => "en"), :item => item)
item.item_locales << ItemLocale.new(:locale => Locale.new(:name => "Desayuno con hamburguesas", :description => "Desayuno con hamburguesas", :locale => "es"), :item => item)
item.save

item = Item.new(:photo => "menu/snacks/5.jpg", :group_id => 4)
item.item_locales = []
item.item_locales << ItemLocale.new(:locale => Locale.new(:name => "Яичница болтунья", :description => "Яичница болтунья", :locale => "ru"), :item => item)
item.item_locales << ItemLocale.new(:locale => Locale.new(:name => "Scrambled eggs", :description => "Scrambled eggs", :locale => "en"), :item => item)
item.item_locales << ItemLocale.new(:locale => Locale.new(:name => "Huevos revueltos", :description => "Huevos revueltos", :locale => "es"), :item => item)
item.save

item = Item.new(:photo => "menu/soups/1.jpg", :group_id => 5)
item.item_locales = []
item.item_locales << ItemLocale.new(:locale => Locale.new(:name => "Суп с лапшой", :description => "Суп с лапшой", :locale => "ru"), :item => item)
item.item_locales << ItemLocale.new(:locale => Locale.new(:name => "Noodle soup", :description => "Noodle soup", :locale => "en"), :item => item)
item.item_locales << ItemLocale.new(:locale => Locale.new(:name => "Sopa con fideos", :description => "Sopa con fideos", :locale => "es"), :item => item)
item.save

item = Item.new(:photo => "menu/soups/2.jpg", :group_id => 5)
item.item_locales = []
item.item_locales << ItemLocale.new(:locale => Locale.new(:name => "Томатный суп", :description => "Томатный суп", :locale => "ru"), :item => item)
item.item_locales << ItemLocale.new(:locale => Locale.new(:name => "Tomatoo soup", :description => "Tomatoo soup", :locale => "en"), :item => item)
item.item_locales << ItemLocale.new(:locale => Locale.new(:name => "Sopa de tomate", :description => "Sopa de tomate", :locale => "es"), :item => item)
item.save

item = Item.new(:photo => "menu/soups/3.jpg", :group_id => 5)
item.item_locales = []
item.item_locales << ItemLocale.new(:locale => Locale.new(:name => "Солянка", :description => "Солянка", :locale => "ru"), :item => item)
item.item_locales << ItemLocale.new(:locale => Locale.new(:name => "Vegetable soup", :description => "Vegetable soup", :locale => "en"), :item => item)
item.item_locales << ItemLocale.new(:locale => Locale.new(:name => "Sopa con verduras", :description => "Sopa con verduras", :locale => "es"), :item => item)
item.save

code = GameCode.new(:code => '000', :bonus => Random.rand(1000)+1, :days => Random.rand(10)+1)
code.save
code = GameCode.new(:code => '010', :bonus => Random.rand(1000)+1, :days => Random.rand(10)+1)
code.save
code = GameCode.new(:code => '020', :bonus => Random.rand(1000)+1, :days => Random.rand(10)+1)
code.save
code = GameCode.new(:code => '030', :bonus => Random.rand(1000)+1, :days => Random.rand(10)+1)
code.save
code = GameCode.new(:code => '040', :bonus => Random.rand(1000)+1, :days => Random.rand(10)+1)
code.save
code = GameCode.new(:code => '050', :bonus => Random.rand(1000)+1, :days => Random.rand(10)+1)
code.save
code = GameCode.new(:code => '060', :bonus => Random.rand(1000)+1, :days => Random.rand(10)+1)
code.save
code = GameCode.new(:code => '070', :bonus => Random.rand(1000)+1, :days => Random.rand(10)+1)
code.save
code = GameCode.new(:code => '080', :bonus => Random.rand(1000)+1, :days => Random.rand(10)+1)
code.save
code = GameCode.new(:code => '090', :bonus => Random.rand(1000)+1, :days => Random.rand(10)+1)
code.save
code = GameCode.new(:code => '101', :bonus => Random.rand(1000)+1, :days => Random.rand(10)+1)
code.save
code = GameCode.new(:code => '111', :bonus => Random.rand(1000)+1, :days => Random.rand(10)+1)
code.save
code = GameCode.new(:code => '121', :bonus => Random.rand(1000)+1, :days => Random.rand(10)+1)
code.save
code = GameCode.new(:code => '131', :bonus => Random.rand(1000)+1, :days => Random.rand(10)+1)
code.save
code = GameCode.new(:code => '141', :bonus => Random.rand(1000)+1, :days => Random.rand(10)+1)
code.save
code = GameCode.new(:code => '151', :bonus => Random.rand(1000)+1, :days => Random.rand(10)+1)
code.save
code = GameCode.new(:code => '161', :bonus => Random.rand(1000)+1, :days => Random.rand(10)+1)
code.save
code = GameCode.new(:code => '171', :bonus => Random.rand(1000)+1, :days => Random.rand(10)+1)
code.save
code = GameCode.new(:code => '181', :bonus => Random.rand(1000)+1, :days => Random.rand(10)+1)
code.save
code = GameCode.new(:code => '191', :bonus => Random.rand(1000)+1, :days => Random.rand(10)+1)
code.save
code = GameCode.new(:code => '202', :bonus => Random.rand(1000)+1, :days => Random.rand(10)+1)
code.save
code = GameCode.new(:code => '212', :bonus => Random.rand(1000)+1, :days => Random.rand(10)+1)
code.save
code = GameCode.new(:code => '222', :bonus => Random.rand(1000)+1, :days => Random.rand(10)+1)
code.save
code = GameCode.new(:code => '232', :bonus => Random.rand(1000)+1, :days => Random.rand(10)+1)
code.save
code = GameCode.new(:code => '242', :bonus => Random.rand(1000)+1, :days => Random.rand(10)+1)
code.save
code = GameCode.new(:code => '252', :bonus => Random.rand(1000)+1, :days => Random.rand(10)+1)
code.save
code = GameCode.new(:code => '262', :bonus => Random.rand(1000)+1, :days => Random.rand(10)+1)
code.save
code = GameCode.new(:code => '272', :bonus => Random.rand(1000)+1, :days => Random.rand(10)+1)
code.save
code = GameCode.new(:code => '282', :bonus => Random.rand(1000)+1, :days => Random.rand(10)+1)
code.save
code = GameCode.new(:code => '292', :bonus => Random.rand(1000)+1, :days => Random.rand(10)+1)
code.save
code = GameCode.new(:code => '303', :bonus => Random.rand(1000)+1, :days => Random.rand(10)+1)
code.save
code = GameCode.new(:code => '313', :bonus => Random.rand(1000)+1, :days => Random.rand(10)+1)
code.save
code = GameCode.new(:code => '323', :bonus => Random.rand(1000)+1, :days => Random.rand(10)+1)
code.save
code = GameCode.new(:code => '333', :bonus => Random.rand(1000)+1, :days => Random.rand(10)+1)
code.save
code = GameCode.new(:code => '343', :bonus => Random.rand(1000)+1, :days => Random.rand(10)+1)
code.save
code = GameCode.new(:code => '353', :bonus => Random.rand(1000)+1, :days => Random.rand(10)+1)
code.save
code = GameCode.new(:code => '363', :bonus => Random.rand(1000)+1, :days => Random.rand(10)+1)
code.save
code = GameCode.new(:code => '373', :bonus => Random.rand(1000)+1, :days => Random.rand(10)+1)
code.save
code = GameCode.new(:code => '383', :bonus => Random.rand(1000)+1, :days => Random.rand(10)+1)
code.save
code = GameCode.new(:code => '393', :bonus => Random.rand(1000)+1, :days => Random.rand(10)+1)
code.save
code = GameCode.new(:code => '404', :bonus => Random.rand(1000)+1, :days => Random.rand(10)+1)
code.save
code = GameCode.new(:code => '414', :bonus => Random.rand(1000)+1, :days => Random.rand(10)+1)
code.save
code = GameCode.new(:code => '424', :bonus => Random.rand(1000)+1, :days => Random.rand(10)+1)
code.save
code = GameCode.new(:code => '434', :bonus => Random.rand(1000)+1, :days => Random.rand(10)+1)
code.save
code = GameCode.new(:code => '444', :bonus => Random.rand(1000)+1, :days => Random.rand(10)+1)
code.save
code = GameCode.new(:code => '454', :bonus => Random.rand(1000)+1, :days => Random.rand(10)+1)
code.save
code = GameCode.new(:code => '464', :bonus => Random.rand(1000)+1, :days => Random.rand(10)+1)
code.save
code = GameCode.new(:code => '474', :bonus => Random.rand(1000)+1, :days => Random.rand(10)+1)
code.save
code = GameCode.new(:code => '484', :bonus => Random.rand(1000)+1, :days => Random.rand(10)+1)
code.save
code = GameCode.new(:code => '494', :bonus => Random.rand(1000)+1, :days => Random.rand(10)+1)
code.save
code = GameCode.new(:code => '505', :bonus => Random.rand(1000)+1, :days => Random.rand(10)+1)
code.save
code = GameCode.new(:code => '515', :bonus => Random.rand(1000)+1, :days => Random.rand(10)+1)
code.save
code = GameCode.new(:code => '525', :bonus => Random.rand(1000)+1, :days => Random.rand(10)+1)
code.save
code = GameCode.new(:code => '535', :bonus => Random.rand(1000)+1, :days => Random.rand(10)+1)
code.save
code = GameCode.new(:code => '545', :bonus => Random.rand(1000)+1, :days => Random.rand(10)+1)
code.save
code = GameCode.new(:code => '555', :bonus => Random.rand(1000)+1, :days => Random.rand(10)+1)
code.save
code = GameCode.new(:code => '565', :bonus => Random.rand(1000)+1, :days => Random.rand(10)+1)
code.save
code = GameCode.new(:code => '575', :bonus => Random.rand(1000)+1, :days => Random.rand(10)+1)
code.save
code = GameCode.new(:code => '585', :bonus => Random.rand(1000)+1, :days => Random.rand(10)+1)
code.save
code = GameCode.new(:code => '595', :bonus => Random.rand(1000)+1, :days => Random.rand(10)+1)
code.save
code = GameCode.new(:code => '606', :bonus => Random.rand(1000)+1, :days => Random.rand(10)+1)
code.save
code = GameCode.new(:code => '616', :bonus => Random.rand(1000)+1, :days => Random.rand(10)+1)
code.save
code = GameCode.new(:code => '626', :bonus => Random.rand(1000)+1, :days => Random.rand(10)+1)
code.save
code = GameCode.new(:code => '636', :bonus => Random.rand(1000)+1, :days => Random.rand(10)+1)
code.save
code = GameCode.new(:code => '646', :bonus => Random.rand(1000)+1, :days => Random.rand(10)+1)
code.save
code = GameCode.new(:code => '656', :bonus => Random.rand(1000)+1, :days => Random.rand(10)+1)
code.save
code = GameCode.new(:code => '666', :bonus => Random.rand(1000)+1, :days => Random.rand(10)+1)
code.save
code = GameCode.new(:code => '676', :bonus => Random.rand(1000)+1, :days => Random.rand(10)+1)
code.save
code = GameCode.new(:code => '686', :bonus => Random.rand(1000)+1, :days => Random.rand(10)+1)
code.save
code = GameCode.new(:code => '696', :bonus => Random.rand(1000)+1, :days => Random.rand(10)+1)
code.save
code = GameCode.new(:code => '707', :bonus => Random.rand(1000)+1, :days => Random.rand(10)+1)
code.save
code = GameCode.new(:code => '717', :bonus => Random.rand(1000)+1, :days => Random.rand(10)+1)
code.save
code = GameCode.new(:code => '727', :bonus => Random.rand(1000)+1, :days => Random.rand(10)+1)
code.save
code = GameCode.new(:code => '737', :bonus => Random.rand(1000)+1, :days => Random.rand(10)+1)
code.save
code = GameCode.new(:code => '747', :bonus => Random.rand(1000)+1, :days => Random.rand(10)+1)
code.save
code = GameCode.new(:code => '757', :bonus => Random.rand(1000)+1, :days => Random.rand(10)+1)
code.save
code = GameCode.new(:code => '767', :bonus => Random.rand(1000)+1, :days => Random.rand(10)+1)
code.save
code = GameCode.new(:code => '777', :bonus => Random.rand(1000)+1, :days => Random.rand(10)+1)
code.save
code = GameCode.new(:code => '787', :bonus => Random.rand(1000)+1, :days => Random.rand(10)+1)
code.save
code = GameCode.new(:code => '797', :bonus => Random.rand(1000)+1, :days => Random.rand(10)+1)
code.save
code = GameCode.new(:code => '808', :bonus => Random.rand(1000)+1, :days => Random.rand(10)+1)
code.save
code = GameCode.new(:code => '818', :bonus => Random.rand(1000)+1, :days => Random.rand(10)+1)
code.save
code = GameCode.new(:code => '828', :bonus => Random.rand(1000)+1, :days => Random.rand(10)+1)
code.save
code = GameCode.new(:code => '838', :bonus => Random.rand(1000)+1, :days => Random.rand(10)+1)
code.save
code = GameCode.new(:code => '848', :bonus => Random.rand(1000)+1, :days => Random.rand(10)+1)
code.save
code = GameCode.new(:code => '858', :bonus => Random.rand(1000)+1, :days => Random.rand(10)+1)
code.save
code = GameCode.new(:code => '868', :bonus => Random.rand(1000)+1, :days => Random.rand(10)+1)
code.save
code = GameCode.new(:code => '878', :bonus => Random.rand(1000)+1, :days => Random.rand(10)+1)
code.save
code = GameCode.new(:code => '888', :bonus => Random.rand(1000)+1, :days => Random.rand(10)+1)
code.save
code = GameCode.new(:code => '898', :bonus => Random.rand(1000)+1, :days => Random.rand(10)+1)
code.save
code = GameCode.new(:code => '909', :bonus => Random.rand(1000)+1, :days => Random.rand(10)+1)
code.save
code = GameCode.new(:code => '919', :bonus => Random.rand(1000)+1, :days => Random.rand(10)+1)
code.save
code = GameCode.new(:code => '929', :bonus => Random.rand(1000)+1, :days => Random.rand(10)+1)
code.save
code = GameCode.new(:code => '939', :bonus => Random.rand(1000)+1, :days => Random.rand(10)+1)
code.save
code = GameCode.new(:code => '949', :bonus => Random.rand(1000)+1, :days => Random.rand(10)+1)
code.save
code = GameCode.new(:code => '959', :bonus => Random.rand(1000)+1, :days => Random.rand(10)+1)
code.save
code = GameCode.new(:code => '969', :bonus => Random.rand(1000)+1, :days => Random.rand(10)+1)
code.save
code = GameCode.new(:code => '979', :bonus => Random.rand(1000)+1, :days => Random.rand(10)+1)
code.save
code = GameCode.new(:code => '989', :bonus => Random.rand(1000)+1, :days => Random.rand(10)+1)
code.save
code = GameCode.new(:code => '999', :bonus => Random.rand(1000)+1, :days => Random.rand(10)+1)
code.save

50.times do |i|
	ItemProperty.new(:item_id => Random.rand(28)+1, :property_id => Random.rand(10)+1, :value => "This is testing value ##{i.to_s}").save
end

menu = Menu.create :startdate => Time.now.localtime.strftime("%Y-%m-%d"), :enddate => 1.month.from_now.strftime("%Y-%m-%d")
menu.menu_locales = []
menu.menu_locales << MenuLocale.new(:locale => Locale.new(:name => "Меню №1", :locale => "ru"), :menu => menu)
menu.menu_locales << MenuLocale.new(:locale => Locale.new(:name => "Menu #1", :locale => "en"), :menu => menu)
menu.menu_locales << MenuLocale.new(:locale => Locale.new(:name => "Menu #1", :locale => "es"), :menu => menu)
menu.save

28.times do |i|
	MenuItem.new(:item_id => i+1, :cost => Random.rand(100)+1, :menu => menu).save()
end
