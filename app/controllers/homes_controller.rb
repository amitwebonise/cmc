class HomesController < ApplicationController

  def index

  end

  def dashboard
    @activities = Activity.all
  end
end
