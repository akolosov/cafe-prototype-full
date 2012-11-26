class ItemsController < ApplicationController
  load_and_authorize_resource

  # GET /items
  # GET /items.json
  def index
    @items = Item.accessible_by(current_ability)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @items }
      format.xml  { render xml: @items }
    end
  end

  # GET /items/1
  # GET /items/1.json
  def show
    @item = Item.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @item }
      format.xml  { render xml: @item }
    end
  end

  # GET /items/new
  # GET /items/new.json
  def new
    @item = Item.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @item }
      format.xml  { render xml: @item }
    end
  end

  # GET /items/1/edit
  def edit
    @item = Item.find(params[:id])
  end

  # POST /items
  # POST /items.json
  def create
    @item = Item.new(params[:item])
 
    @item.item_locales = []

    params[:item_locales].each do |locale, values|
      @item.item_locales << ItemLocale.new(:locale => Locale.new(values), :item => @item)
    end

    respond_to do |format|
      if @item.save
        format.html { redirect_to @item, notice: 'Item was successfully created.' }
        format.json { render json: @item, status: :created, location: @item }
        format.xml  { render xml: @item, status: :created, location: @item }
      else
        format.html { render action: "new" }
        format.json { render json: @item.errors, status: :unprocessable_entity }
        format.xml  { render xml: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /items/1
  # PUT /items/1.json
  def update
    @item = Item.find(params[:id])

    params[:item_locales].each do |loc, values|
      locale = Locale.find(values[:id])
      locale.name = values[:name]
      locale.description = values[:description]
      locale.locale = values[:locale]
      locale.save
    end

    respond_to do |format|
      if @item.update_attributes(params[:item])
        format.html { redirect_to @item, notice: 'Item was successfully updated.' }
        format.json { head :ok }
        format.xml  { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @item.errors, status: :unprocessable_entity }
        format.xml  { render xml: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    @item = Item.find(params[:id])
    @item.destroy

    respond_to do |format|
      format.html { redirect_to items_url }
      format.json { head :ok }
      format.xml  { head :ok }
    end
  end
end
