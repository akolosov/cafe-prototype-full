class UserPropertiesController < ApplicationController
  load_and_authorize_resource

  # GET /user_properties
  # GET /user_properties.json
  def index
    @user = User.find(params[:user_id])
    @user_property = @user.user_property

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @user_property }
      format.xml  { render xml: @user_property }
    end
  end

  # GET /user_properties/1
  # GET /user_properties/1.json
  def show
    @user_property = UserProperty.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user_property }
      format.xml  { render xml: @user_property }
    end
  end

  # GET /user_properties/new
  # GET /user_properties/new.json
  def new
    @user_property = UserProperty.new
    @user_property.user = User.find(params[:user_id])

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user_property }
      format.xml  { render xml: @user_property }
    end
  end

  # GET /user_properties/1/edit
  def edit
    @user_property = UserProperty.find(params[:id])
  end

  # POST /user_properties
  # POST /user_properties.json
  def create
    @user_property = UserProperty.new(params[:user_property])

    respond_to do |format|
      if @user_property.save
        format.html { redirect_to user_property_url(@user_property.user, @user_property), notice: 'User property was successfully created.' }
        format.json { render json: @user_property, status: :created, location: @user_property }
        format.xml  { render xml: @user_property, status: :created, location: @user_property }
      else
        format.html { render action: "new" }
        format.json { render json: @user_property.errors, status: :unprocessable_entity }
        format.xml  { render xml: @user_property.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /user_properties/1
  # PUT /user_properties/1.json
  def update
    @user_property = UserProperty.find(params[:id])

    respond_to do |format|
      if @user_property.update_attributes(params[:user_property])
        format.html { redirect_to user_property_url(@user_property.user, @user_property), notice: 'User property was successfully updated.' }
        format.json { head :ok }
        format.xml  { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @user_property.errors, status: :unprocessable_entity }
        format.xml  { render xml: @user_property.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_properties/1
  # DELETE /user_properties/1.json
  def destroy
    @user_property = UserProperty.find(params[:id])
    @user_property.destroy

    respond_to do |format|
      format.html { redirect_to user_properties_url }
      format.json { head :ok }
      format.xml  { head :ok }
    end
  end
end
