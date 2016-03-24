class CoursesController < ApplicationController
  # before_action :authenticate_user!

  def index
    render json: Course.all
  end
end
