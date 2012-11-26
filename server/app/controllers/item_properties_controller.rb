class ItemPropertiesController < ApplicationController
  load_and_authorize_resource

  # GET /item_properties
  # GET /item_properties.json
  def index
    @item = Item.find(params[:item_id])
    @item_properties = @item.item_properties

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @item_properties }
      format.xml  { render xml: @item_properties }
    end
  end

  # GET /item_properties/1
  # GET /item_properties/1.json
  def show
    @item_property = ItemProperty.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @item_property }
      format.xml  { render xml: @item_property }
    end
  end

  # GET /item_properties/new
  # GET /item_properties/new.json
  def new
    @item_property = ItemProperty.new
    @item_property.item = Item.find(params[:item_id])

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @item_property }
      format.xml  { render xml: @item_property }
    end
  end

  # GET /item_properties/1/edit
  def edit
    @item_property = ItemProperty.find(params[:id])
  end

  # POST /item_properties
  # POST /item_properties.json
  def create
    @item_property = ItemProperty.new(params[:item_property])

    respond_to do |format|
      if @item_property.save
        format.html { redirect_to item_property_url(@item_property.item, @item_property), notice: 'Item property was successfully created.' }
        format.json { render json: @item_property, status: :created, location: @item_property }
        format.xml  { render xml: @item_property, status: :created, location: @item_property }
      else
        format.html { render action: "new" }
        format.json { render json: @item_property.errors, status: :unprocessable_entity }
        format.xml  { render xml: @item_property.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /item_properties/1
  # PUT /item_properties/1.json
  def update
    @item_property = ItemProperty.find(params[:id])

    respond_to do |format|
      if @item_property.update_attributes(params[:item_property])
        format.html { redirect_to item_property_url(@item_property.item, @item_property), notice: 'Item property was successfully updated.' }
        format.json { head :ok }
        format.xml  { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @item_property.errors, status: :unprocessable_entity }
        format.xml  { render xml: @item_property.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /item_properties/1
  # DELETE /item_properties/1.json
  def destroy
    @item_property = ItemProperty.find(params[:id])
    @item_property.destroy

    respond_to do |format|
      format.html { redirect_to item_properties_url }
      format.json { head :ok }
      format.xml  { head :ok }
    end
  end
end
