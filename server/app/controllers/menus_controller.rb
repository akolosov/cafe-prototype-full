class MenusController < ApplicationController
  load_and_authorize_resource

  # GET /menus
  # GET /menus.json
  def index
    @menus = Menu.accessible_by(current_ability)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @menus }
      format.xml  { render xml:  @menus }
    end
  end

  # GET /menus/1
  # GET /menus/1.json
  def show
    @menu = Menu.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @menu }
      format.xml  { render xml: @menu }
    end
  end

  # GET /menus/new
  # GET /menus/new.json
  def new
    @menu = Menu.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @menu }
      format.xml  { render xml: @menu }
    end
  end

  # GET /menus/1/edit
  def edit
    @menu = Menu.find(params[:id])
  end

  # POST /menus
  # POST /menus.json
  def create
    @menu = Menu.new(params[:menu])

    @menu.menu_locales = []

    params[:menu_locales].each do |locale, values|
      @menu.menu_locales << MenuLocale.new(:locale => Locale.new(values), :menu => @menu)
    end

    respond_to do |format|
      if @menu.save
        format.html { redirect_to @menu, notice: 'Menu was successfully created.' }
        format.json { render json: @menu, status: :created, location: @menu }
        format.xml  { render xml: @menu, status: :created, location: @menu }
      else
        format.html { render action: "new" }
        format.json { render json: @menu.errors, status: :unprocessable_entity }
        format.xml  { render xml: @menu.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /menus/1
  # PUT /menus/1.json
  def update
    @menu = Menu.find(params[:id])

    params[:menu_locales].each do |loc, values|
      locale = Locale.find(values[:id])
      locale.name = values[:name]
      locale.locale = values[:locale]
      locale.save
    end

    respond_to do |format|
      if @menu.update_attributes(params[:menu])
        format.html { redirect_to @menu, notice: 'Menu was successfully updated.' }
        format.json { head :ok }
        format.xml  { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @menu.errors, status: :unprocessable_entity }
        format.xml  { render xml: @menu.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /menus/1
  # DELETE /menus/1.json
  def destroy
    @menu = Menu.find(params[:id])
    @menu.destroy

    respond_to do |format|
      format.html { redirect_to menus_url }
      format.json { head :ok }
      format.xml  { head :ok }
    end
  end
end
