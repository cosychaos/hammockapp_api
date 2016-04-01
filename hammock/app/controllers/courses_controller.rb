class CoursesController < ApplicationController
  before_action :authenticate_user!

  respond_to :json

  def index
    render json: Course.where(user_id: current_user.id)
  end

  def show
    @course = Course.find(params[:id])
    render json: @course
  end

  def create
    @course = Course.build_with_user(course_params, current_user) unless course_params[:id]
    @course = Course.build_with_clone(Courseitem.find(course_params[:id]), current_user, course_params[:status]) if course_params[:id]
    render json: @course, status: :created, location: @course if @course.save
    render json: @course.errors, status: :unprocessable_entity unless @course.save
  end

  def update
    @course = Course.find(course_params[:id])
    if @course.update_attributes(course_params)
      render json: @course, status: :created, location: @course
    else
      render json: @course.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @course = Course.find(course_params[:id])
    if @course.destroy
      render json: {}, status: :no_content
    else
      render json: @course.errors, status: :unprocessable_entity
    end
  end

  private

  def course_params
    params.require(:course).permit(:provider, :name, :description, :organisation, :image, :url, :status, :id)
  end
end
