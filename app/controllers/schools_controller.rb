class SchoolsController < ApplicationController

  before_action :authorize_admin!, except: [:index, :show]
  before_action :set_school, only: [:show, :update, :destroy]

  def index
    @schools = School.all
    render json: @schools
  end

  def show
    render json: @school
  end

  def create
    @school = School.new(school_params)
    if @school.save
      render json: @school, status: :created
    else
      render json: @school.errors, status: :unprocessable_entity
    end
  end

  def update
    if @school.update(school_params)
      render json: @school
    else
      render json: @school.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @school.destroy
    head :no_content
  end

  private

  def set_school
    @school = School.find(params[:id])
  end

  def school_params
    params.require(:school).permit(:name, :location)
  end
end
