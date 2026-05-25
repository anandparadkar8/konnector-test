module Admin
  class SchoolsController < ApplicationController
    before_action :authorize_admin!
    before_action :set_school, only: [:show, :update, :destroy, :courses]

    def index
      render json: School.all
    end

    def show
      render json: @school
    end

    def create
      school = School.new(school_params)
      if school.save
        render json: school, status: :created
      else
        render json: { errors: school.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def update
      if @school.update(school_params)
        render json: @school
      else
        render json: { errors: @school.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def destroy
      @school.destroy
      head :no_content
    end

    # List all courses of the school
    def courses
      render json: @school.courses
    end

    private

    def set_school
      @school = School.find(params[:id])
    end

    def school_params
      params.require(:school).permit(:name, :location)
    end
  end
end
