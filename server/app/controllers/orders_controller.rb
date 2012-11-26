class OrdersController < ApplicationController
#  skip_before_filter :require_login, :only => [ :show, :index ]
#  skip_authorize_resource :only => [ :show, :index ]
  skip_authorize_resource 
  skip_before_filter :require_login
  load_and_authorize_resource

  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.accessible_by(current_ability)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @orders }
      format.xml  { render xml: @orders }
    end
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
    @order = Order.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @order }
      format.xml  { render xml: @order }
    end
  end

  # GET /orders/new
  # GET /orders/new.json
  def new
    @order = Order.new
    @order.closed = false
    @order.user = @current_user
    @order.session = request.session_options[:id]

    if (@current_user)
      if (@current_user.user_property) 
        @order.phone = @current_user.user_property.phone
        @order.address = @current_user.user_property.address
      end
    end

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @order }
      format.xml  { render xml: @order }
    end
  end

  # GET /orders/1/edit
  def edit
    @order = Order.find(params[:id])
  end

  # GET /orders/1/close
  def close
    @order = Order.find(params[:id])
    @order.closed = !@order.closed
    @order.status = "*closed*"
    @order.save
    redirect_to orders_url
  end

  # GET /orders/1/check
  def check
    @order = Order.find(params[:id])
    @order.checked = !@order.checked
    @order.status = "*checked*"
    @order.save
    redirect_to orders_url
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(params[:order])
    @order.closed = false

    respond_to do |format|
      if @order.save
        format.html { redirect_to @order, notice: 'Order was successfully created.' }
        format.json { render json: @order, status: :created, location: @order }
        format.xml  { render xml: @order, status: :created, location: @order }
      else
        format.html { render action: "new" }
        format.json { render json: @order.errors, status: :unprocessable_entity }
        format.xml  { render xml: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /orders/1
  # PUT /orders/1.json
  def update
    @order = Order.find(params[:id])

    respond_to do |format|
      if @order.update_attributes(params[:order])
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { head :ok }
        format.xml  { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @order.errors, status: :unprocessable_entity }
        format.xml  { render xml: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order = Order.find(params[:id])
    @order.destroy

    respond_to do |format|
      format.html { redirect_to orders_url }
      format.json { head :ok }
      format.xml  { head :ok }
    end
  end
end
