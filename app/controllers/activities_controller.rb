class ActivitiesController < ApplicationController
  before_filter :authenticate_user!
  # GET /activities
  # GET /activities.json
  def index
    @activities = current_user.activities
    @medias = Media.all.collect{|m| [m.name,m.id]}
    @categories = Category.all.collect{|m| [m.name,m.id]}
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @activities }
    end
  end

  # GET /activities/1
  # GET /activities/1.json
  def show
    @activity = current_user.activities.find(params[:id])
    @shames =  @activity.shames
    @comments = @activity.comments
    @is_shamed =  @activity.shame_ids.include?(current_user.id)
  respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @activity }
    end
  end

  # GET /activities/new
  # GET /activities/new.json
  def new
    @activity = current_user.activities.new
    @location = @activity.build_location
    @medias = Media.all.collect{|m| [m.name,m.id]}
    @categories = Category.all.collect{|m| [m.name,m.id]}
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @activity }
    end
  end

  # GET /activities/1/edit
  def edit
    @activity = current_user.activities.find(params[:id])
    @medias = Media.all.collect{|m| [m.name,m.id]}
    @categories = Category.all.collect{|m| [m.name,m.id]}
  end

  # POST /activities
  # POST /activities.json
  def create
    @activity = Activity.new(params[:activity])
    @activity.user_id = current_user.id
    @location = @activity.build_location
    @medias = Media.all.collect{|m| [m.name,m.id]}
    @categories = Category.all.collect{|m| [m.name,m.id]}
    respond_to do |format|
      if @activity.save
        @location = Location.create(params[:location]) if params[:location].present?
        @location.update_attribute("activity_id",@activity.id) if params[:location].present?
        format.html { redirect_to activities_path, notice: 'Activity was successfully created.' }
        format.json { render json: @activity, status: :created, location: @activity }
      else
        format.html { render action: "new" }
        format.json { render json: @activity.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /activities/1
  # PUT /activities/1.json
  def update
    @activity = Activity.find(params[:id])

    respond_to do |format|
      if @activity.update_attributes(params[:activity])
        format.html { redirect_to @activity, notice: 'Activity was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @activity.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /activities/1
  # DELETE /activities/1.json
  def destroy
    @activity = Activity.find(params[:id])
    @activity.destroy

    respond_to do |format|
      format.html { redirect_to activities_url }
      format.json { head :no_content }
    end
  end

  def comment
    @activity = Activity.find(params[:id])
    @comment  = @activity.comments.create(:user_id => current_user.id, :description => params[:description])
   if @comment.save
    redirect_to activity_path(@activity), :notice => "Thank You for posting the Comment"
   else
     redirect_to activity_path(@activity), :notice => "Sorry ! Empty comment is not Allowed"
   end
  end

  def shame
    @activity = Activity.find(params[:id])
    @comment  = @activity.shames.create(:user_id => current_user.id)
    if @comment.save
      redirect_to activity_path(@activity), :notice => "Thank You for Participate. it really help a lot to this activity"
    else
      redirect_to activity_path(@activity), :notice => "Sorry ! Empty comment is not Allowed"
    end
  end

  def email

  end
end
