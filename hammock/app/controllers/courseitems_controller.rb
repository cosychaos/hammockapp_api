class CourseitemsController < ApplicationController
  before_action :authenticate_user!


  def index
    render json: Courseitem.all
  end

end
