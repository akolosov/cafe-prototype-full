class GroupsController < ApplicationController

  load_and_authorize_resource

  # GET /groups
  # GET /groups.json
  def index
    @groups = Group.accessible_by(current_ability)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @groups }
      format.xml { render xml: @groups }
    end
  end

  # GET /groups/1
  # GET /groups/1.json
  def show
    @group = Group.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @group }
      format.xml { render xml: @group }
    end
  end

  # GET /groups/new
  # GET /groups/new.json
  def new
    @group = Group.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @group }
      format.xml { render xml: @group }
    end
  end

  # GET /groups/1/edit
  def edit
    @group = Group.find(params[:id])
  end

  # POST /groups
  # POST /groups.json
  def create
    @group = Group.new(params[:group])

    @group.group_locales = []

    params[:group_locales].each do |locale, values|
      @group.group_locales << GroupLocale.new(:locale => Locale.new(values), :group => @group)
    end

    respond_to do |format|
      if @group.save
        format.html { redirect_to @group, notice: 'Group was successfully created.' }
        format.json { render json: @group, status: :created, location: @group }
        format.xml { render xml: @group, status: :created, location: @group }
      else
        format.html { render action: "new" }
        format.json { render json: @group.errors, status: :unprocessable_entity }
        format.xml { render xml: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /groups/1
  # PUT /groups/1.json
  def update
    @group = Group.find(params[:id])

    params[:group_locales].each do |loc, values|
      locale = Locale.find(values[:id])
      locale.name = values[:name]
      locale.description = values[:description]
      locale.locale = values[:locale]
      locale.save
    end

    respond_to do |format|
      if @group.update_attributes(params[:group])
        format.html { redirect_to @group, notice: 'Group was successfully updated.' }
        format.json { head :ok }
        format.xml { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @group.errors, status: :unprocessable_entity }
        format.xml { render xml: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /groups/1
  # DELETE /groups/1.json
  def destroy
    @group = Group.find(params[:id])
    @group.destroy

    respond_to do |format|
      format.html { redirect_to groups_url }
      format.json { head :ok }
      format.xml { head :ok }
    end
  end
end
