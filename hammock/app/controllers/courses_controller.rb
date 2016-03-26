class CoursesController < ApplicationController
  before_action :authenticate_user!

  def index
    render json: Course.where(user_id: current_user.id)
  end

  def create
    if current_user
      @course = current_user.courses.create(course_params)
      render json: @course, status: :created, location: @course
    else
      render json: @course.errors, status: :unprocessable_entity
    end
  end

  def update
    attributes = course_params.clone
    if current_user
      @course = current_user.courses.where(name: attributes[:name]).update_attributes(course_params)
      render json: @course, status: :created, location: @course
    else
      render json: @course.errors, status: :unprocessable_entity
    end
  end

  private

  def course_params
    params.require(:course).permit(:provider, :name, :description, :organisation, :image, :url, :status, :duration)
  end
end
