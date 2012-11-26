class MainController < ApplicationController

  respond_to :json

  skip_before_filter :require_login
  #, :only => [ :getgroupslist, :index ]

  # load_and_authorize_resource

  skip_authorize_resource
  #:only => [ :getgroupslist, :index ]

  before_filter :setlocale
 
  before_filter :require_login, :only =>  [ :putuserbonus ]

  authorize_resource :only =>  [ :putuserbonus ]

  def index
  end

  # GET /main/getgroupslist/json
  def getgroupslist
    @groups = Group.all
    respond_with @groups # render template from /app/views/main/getgroupslist.json.erb
  end

  # GET /main/getcurrentmenuheaders/json
  def getcurrentmenuheaders
    @menus = Menu.find(:all, :conditions => ['startdate <= ? and enddate >= ?', Time.now.localtime.strftime("%Y-%m-%d"), Time.now.localtime.strftime("%Y-%m-%d") ])
    respond_with @menus # render template from /app/views/main/getcurrentmenuheaders.json.erb
  end

  # GET /main/getmenuitems/:menu_id/json
  def getmenuitems
    @menu_items = MenuItem.find(:all, :conditions => ['menu_id = ?', params[:menu_id]])
    respond_with @menu_items # render template from /app/views/main/getmenuitems.json.erb
  end

  # GET /main/getmenuitem/:item_id/json
  def getmenuitem
    @menu_item = MenuItem.find(params[:item_id])
    respond_with @menu_item # render template from /app/views/main/getmenuitem.json.erb
  end

  # GET /main/getorderitems/:order_id/json
  def getorderitems
    @order_items = OrderItem.find(:all, :conditions => ['order_id = ?', params[:order_id]])
    respond_with @order_items # render template from /app/views/main/getorderitems.json.erb
  end

  # GET /main/getcurrentsession/json
  def getcurrentsession
    if (current_user) 
      user_id = current_user.id
    else
      user_id = 0
    end
    render :json => { :result => :ok, :user_id => user_id, :session => request.session_options[:id] }
  end

  # GET /main/getmenuitems/:menu_id/bygroup/:group_id/json
  def getmenuitemsbygroup
    @menu_items = MenuItem.find(:all, :conditions => ['menu_id = ? and item_id in (select id from items where group_id = ?)', params[:menu_id], params[:group_id]])
    respond_with @menu_items # render template from /app/views/main/getmenuitemsbygroup.json.erb
  end

  # GET /main/getmenugroups/:menu_id/json
  def getmenugroups
    @groups = Group.find(:all, :conditions => ['id in (select group_id from items where id in (select item_id from menu_items where menu_id = ?))', params[:menu_id]])
    respond_with @groups # render template from /app/views/main/getmenugroups.json.erb
  end

  # GET /main/getcurrentmenugroups/json
  def getcurrentmenugroups
    @groups = Group.find(:all, :conditions => ['id in (select group_id from items where id in (select item_id from menu_items where menu_id in (select id from menus where startdate <= ? and enddate >= ?)))', Time.now.localtime.strftime("%Y-%m-%d"), Time.now.localtime.strftime("%Y-%m-%d")], :order => 'id desc')
    @groups.uniq!
    @groups.reverse!
    respond_with @groups # render template from /app/views/main/getmenugroups.json.erb
  end

  # GET /main/getcurrentmenuitemsbygroup/:group_id/json
  def getcurrentmenuitemsbygroup
    @menu_items = MenuItem.find(:all, :conditions => ['menu_id in (select id from menus where startdate <= ? and enddate >= ?) and item_id in (select id from items where group_id = ?)', Time.now.localtime.strftime("%Y-%m-%d"), Time.now.localtime.strftime("%Y-%m-%d"), params[:group_id]], :order => 'id desc')
    @menu_items.uniq!
    @menu_items.reverse!
    respond_with @menu_items # render template from /app/views/main/getmenuitemsbygroup.json.erb
  end

  # GET /main/getcurrentmenuitems/:menu_id/json
  def getcurrentmenuitems
    @menu_items = MenuItem.find(:all, :conditions => ['menu_id in (select id from menus where startdate <= ? and enddate >= ?)', Time.now.localtime.strftime("%Y-%m-%d"), Time.now.localtime.strftime("%Y-%m-%d")], :order => 'id desc')
    @menu_items.uniq!
    @menu_items.reverse!
    respond_with @menu_items # render template from /app/views/main/getmenuitems.json.erb
  end

  # GET /main/putorderitem/:order_id/item/:item_id/count/:count/json
  def putorderitem
    if (Order.find(params[:order_id])) && (MenuItem.find(params[:item_id])) && (params[:count].to_i > 0)
      @order_item = OrderItem.find :last, :conditions => ['order_id = ? and menu_item_id = ?', params[:order_id], params[:item_id]]
      if !@order_item
        @order_item = OrderItem.new(:order_id => params[:order_id], :menu_item_id => params[:item_id], :count => params[:count])
      else
        @order_item.count = params[:count]
      end
      @order_item.save
      respond_with @order_item # render template from /app/views/main/putorderitem.json.erb
    elsif (Order.find(params[:order_id])) && (MenuItem.find(params[:item_id])) && (params[:count].to_i <= 0)
      @order_item = OrderItem.find :last, :conditions => ['order_id = ? and menu_item_id = ?', params[:order_id], params[:item_id]]
      if (current_user)
        user_id = current_user.id
      else
        user_id = nil
      end
      if @order_item
        @order_item.destroy
        render :json => { :result => :ok, :user_id => user_id, :session => request.session_options[:id] }
      else
        render :json => { :result => :error, :user_id => user_id, :session => request.session_options[:id] }
      end
    else
      render :json => { :result => :error }
    end
  end

  # GET /main/getordersumm/:order_id/json
  def getordersumm
    summ = 0
    @order_items = OrderItem.find(:all, :conditions => ['order_id = ?', params[:order_id]])
    @order_items.each { |order_item|
       summ = summ + (order_item.count*order_item.menu_item.cost)
    }
    render :json => { :result => summ }
  end

  # GET /main/getcurrentorderheader/json
  def getcurrentorderheader
    if (current_user)
      user_id = current_user.id
    else
      user_id = 0
    end
    @order = Order.find(:last, :conditions => ['(user_id = ? and session = ? and closed = ? and checked = ?) or (user_id is null and session = ? and closed = ? and checked = ?) or (user_id = ? and date(created_at) = ? and closed = ? and checked = ?)', user_id, request.session_options[:id], false, false, request.session_options[:id], false, false, user_id, Time.now.localtime.strftime("%Y-%m-%d"), false, false])
    if !@order 
      @order = Order.new(:user_id => user_id, :session => request.session_options[:id], :closed => false, :checked => false)
      if (current_user)
        if (current_user.user_property) 
          @order.phone = current_user.user_property.phone
          @order.address = current_user.user_property.address
        end
      end
      @order.status = "*new*"
      @order.save
    end
    respond_with @order
  end

  # GET /main/checkorder/:order_id/json
  def checkorder
    if (current_user)
      user_id = current_user.id
    else
      user_id = 0
    end

    @order = Order.find(params[:order_id])
    
    if (@order) then
      if (@order.user)
        user_id = @order.user_id
      else
        user_id = 0
      end

      if (!@order.user) then
        @order.name = params[:name]
      end

      @order.address = params[:address]
      @order.phone = params[:phone]
      @order.additions = params[:additions]
      @order.status = "*checked*"
      @order.checked = true
      if @order.save
        render :json => { :result => :ok, :user_id => user_id, :session => request.session_options[:id] }
      else
        render :json => { :result => :error, :user_id => nil, :session => request.session_options[:id] }
      end
    end

  end

  # GET /main/getuserinfo/:id/json
  def getuserinfo
    @user = User.find(params[:user_id])
    if (@user)
      if (!@user.user_property)
        @user.user_property = UserProperty.new
      end
      respond_with @user
    end
  end

  # GET /main/getuseraccounts/:id/json
  def getuseraccounts
    @user_accounts = User.find(params[:user_id]).user_accounts
    respond_with @user_accounts
  end

  # POST /main/userregister/json
  def userregister
    @user = User.find_by_email(params[:email])

    if (@user)
      render :json => { :result => :error_exists, :user_id => @user.id, :session => request.session_options[:id] }
    else
      @user = User.create :email => params[:email], :password => params[:password], :password_confirmation => params[:password_confirmation]
      @user.roles = 'user'

      @user.user_property = UserProperty.create :name => params[:name], :phone => params[:phone], :address => params[:address]

      if (!params[:birthday]) 
        @user.user_property.birthday = Date.strptime('1980-01-01', '%Y-%m-%d') 
      else
        @user.user_property.birthday = Date.parse(params[:birthday])
      end
      @user.user_property.save

      if @user.save
        if @user = login(params[:email], params[:password], 0) 
          render :json => { :result => :ok, :user_id => @user.id, :session => request.session_options[:id] }
        else
          render :json => { :result => :error_login, :user_id => nil, :session => request.session_options[:id] }
        end
      else
        render :json => { :result => :error_register, :user_id => nil, :session => request.session_options[:id] }
      end
    end
  end

  # POST /main/userlogin/json
  def userlogin
    @user = User.new

    if @user = login(params[:email], params[:password], 0)
      render :json => { :result => :ok, :user_id => @user.id, :session => request.session_options[:id] }
    else
      render :json => { :result => :error_login_user, :user_id => nil, :session => request.session_options[:id] }
    end
  end

  # GET /main/userlogout/json
  def userlogout
    logout
    render :json => { :result => :ok, :user_id => nil, :session => request.session_options[:id] }
  end

  # GET /main/getrandomcode/json
  def getrandomcode
    render :json => { :one => Random.rand(10), :two => Random.rand(10), :three => Random.rand(10) }
  end

  # GET /main/putuserbonus/:code/json
  def putuserbonus
    if (current_user) then
      if @bonus = GameCode.find_by_code(params[:code]) then
        userbonus = UserAccount.new(:user => current_user, :code => @bonus.code, :bonus => @bonus.bonus, :used => false, :expired_at => Time.now.localtime + @bonus.days.days)
        current_user.user_accounts << userbonus
        current_user.save
        render :json => userbonus
      else
        render :json => UserAccount.new
      end
    else
      render :json => UserAccount.new
    end   
  end

  # GET /main/getcurrentuser/json
  def getcurrentuser
    if (current_user) then
      respond_with current_user
    end
  end

protected
  def setlocale
    if (!params[:locale]) then
      params[:locale] = Cafe::Application.config.default_locale
    elsif (!Cafe::Application.config.locale_names.index(params[:locale]))
      params[:locale] = Cafe::Application.config.default_locale
    end
  end

end
