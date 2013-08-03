class ApiController < ApplicationController
  before_filter :authorize_response
  before_filter :check_api_key, :except => [:login, :signup, :forgot_password]
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