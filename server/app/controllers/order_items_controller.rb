class OrderItemsController < ApplicationController
  skip_authorize_resource
  skip_before_filter :require_login
  load_and_authorize_resource

  # GET /order_items
  # GET /order_items.json
  def index
    @order = Order.find(params[:order_id])
    @order_items = @order.order_items

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @order_items }
      format.xml  { render xml: @order_items }
    end
  end

  # GET /order_items/1
  # GET /order_items/1.json
  def show
    @order_item = OrderItem.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @order_item }
      format.xml  { render xml: @order_item }
    end
  end

  # GET /order_items/new
  # GET /order_items/new.json
  def new
    @order_item = OrderItem.new
    @order_item.order = Order.find(params[:order_id])

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @order_item }
      format.xml  { render xml: @order_item }
    end
  end

  # GET /order_items/1/edit
  def edit
    @order_item = OrderItem.find(params[:id])
  end

  # POST /order_items
  # POST /order_items.json
  def create
    @order_item = OrderItem.new(params[:order_item])

    respond_to do |format|
      if @order_item.save
        format.html { redirect_to order_item_url(@order_item.order, @order_item), notice: 'Order item was successfully created.' }
        format.json { render json: @order_item, status: :created, location: @order_item }
        format.xml  { render xml: @order_item, status: :created, location: @order_item }
      else
        format.html { render action: "new" }
        format.json { render json: @order_item.errors, status: :unprocessable_entity }
        format.xml  { render xml: @order_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /order_items/1
  # PUT /order_items/1.json
  def update
    @order_item = OrderItem.find(params[:id])

    respond_to do |format|
      if @order_item.update_attributes(params[:order_item])
        format.html { redirect_to order_item_url(@order_item.order, @order_item), notice: 'Order item was successfully updated.' }
        format.json { head :ok }
        format.xmk  { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @order_item.errors, status: :unprocessable_entity }
        format.xml  { render xml: @order_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /order_items/1
  # DELETE /order_items/1.json
  def destroy
    @order_item = OrderItem.find(params[:id])
    @order_item.destroy

    respond_to do |format|
      format.html { redirect_to order_items_url }
      format.json { head :ok }
      format.xml  { head :ok }
    end
  end
end
