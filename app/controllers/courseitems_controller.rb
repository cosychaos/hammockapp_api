class CourseitemsController < ApplicationController
  # before_action :authenticate_user!

  respond_to :json


  def index
    @user = current_user
    @courseitems = Courseitem.all
  end

end
