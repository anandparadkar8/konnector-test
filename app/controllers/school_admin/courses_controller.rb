module SchoolAdmin
  class CoursesController < ApplicationController
    before_action :authorize_school_admin!
    before_action :set_course, only: [:show, :update, :destroy]

    def index
      render json: current_user.school.courses
    end

    def show
      render json: @course
    end

    def create
      course = current_user.courses.build(course_params)
      course.school = current_user.school
      if course.save
        render json: course, status: :created
      else
        render json: { errors: course.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def update
      if @course.update(course_params)
        render json: @course
      else
        render json: { errors: @course.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def destroy
      @course.destroy
      head :no_content
    end

    private

    def set_course
      @course = current_user.school.courses.find(params[:id])
    end

    def course_params
      params.require(:course).permit(:name, :description)
    end
  end
end
