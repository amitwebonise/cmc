class ApiController < ApplicationController
  respond_to :xml, :json
 before_filter :authorize_response
 before_filter :check_api_key, :except => [:login, :signup, :forgot_password]

 def signup

 end

 def login
 end

 def forgot_password

 end

  private
  def authorize_response
    unless ApiAuthentication.is_response_authenticated?(params)
      last_updated_campaign = Campaign.select(:updated_at).order("updated_at DESC").limit(1).first
      head :last_updated_at => last_updated_campaign.updated_at
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