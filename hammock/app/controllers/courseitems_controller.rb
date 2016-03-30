class CourseitemsController < ApplicationController
  before_action :authenticate_user!

  respond_to :json


  def index
    @courseitems = Courseitem.all
    @user = current_user
  end

end
