class CoursesController < ApplicationController
  before_action :authenticate_user!

  def index
    render json: Course.where(user_id: current_user.id)
  end
end
