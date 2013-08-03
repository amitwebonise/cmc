class ApiController < ApplicationController
  before_filter :authorize_response
  #before_filter :check_api_key, :except => [:login, :signup, :forgot_password]
  respond_to :xml, :json
  def signup
    result = {:success => false}
    user = User.new(:email => params[:email], :password => params[:password], :first_name => params[:first_name], :last_name => params[:last_name],                   :password_confirmation => params[:password])
    if user.save
      result[:user] = user
      result[:success] = true
    else
      result[:errors] = user.errors.full_messages.join(', ')
    end
    render :json => result

  end

  def login
    result = {:success => false}
    user = User.find_by_email(params[:email])
    if user.present? && user.valid_password?(params[:password].strip)
      result[:user] = user
      result[:success] = true
    else
      result[:error] = "Invalid Email/Password"
    end
    render :json => result
  end

  def forgot_password

  end

  def create_activity
    result = {:success => false}
    a = Activity.create(:category_id => params[:category], :subject => params[:subject], :media => [params[:media]], :description => params[:description])
 if a.save
   if params[:image].present?
     file =  File.open(a.id.to_s + ".jpg","wb") do |file|
       file.write(ActiveSupport::Base64.decode64(params[:image]))
     end
     a.image =  File.open(a.id.to_s + ".jpg")
     a.save
     result = {:success => true}
   end
   Location.create(:activity_id => a.id, :latitude => params[:latitude], :longitude => params[:longitude])
   end
     render :json => a.as_json
  end

  def my_activities
     user = User.find(params[:user_id])
    activities =  user.activities.includes(:commennts,:shames).as_json(:methods => [:shame_count, :comment_count])
    render :json =>  activities
  end

  def get_activites_form_data
    render :json => {:media => Media.all.as_json, :categories => Category.all.as_json}
  end

  def get_categories
    @categories = Category.all
  end

  def get_all_Activites
    @activities = Activity.includes(:shames,:comments).as_json(:comments => {:only => :description})
  end

  private
  def authorize_response
    unless ApiAuthentication.is_response_authenticated?(params)
      respond_to do |format|
        format.xml {render :xml => {}}
        format.json {render :json => {}}
      end
    end
  end

  def check_api_key
    @user = User.find_by_api_key(params[:api_key])
    unless @user

      respond_to do |format|
        format.xml {render :xml => {}}
        format.json {render :json => {}}
      end
    end
  end
end