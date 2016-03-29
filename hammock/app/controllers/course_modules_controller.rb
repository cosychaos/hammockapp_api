class CourseModulesController < ApplicationController
  before_action :authenticate_user!

  def index
    render json: CourseModule.where(course_id: params[:course_id])
  end

  def create
    @course_module = CourseModule.new(module_params)
    @course_module.course_id = params[:course_id]
    if @course_module.save
      render json: @course_module, status: :created, location: @course_module
    else
      render json: @course.errors, status: :unprocessable_entity
    end
  end

  def update
    @course_module = CourseModule.find(params[:id])
    if @course_module.update_attributes(module_params)
      render json: @course_module, status: :created, location: @course_module
    else
      render json: @course_module.errors, status: :unprocessable_entity
    end
  end


  def module_params
    params.require(:course_module).permit(:title, :id, :complete)
  end

end
