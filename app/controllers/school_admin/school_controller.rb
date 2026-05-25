module SchoolAdmin
  class SchoolController < ApplicationController
    before_action :authorize_school_admin!

    def show
      render json: current_user.school
    end

    def update
      if current_user.school.update(school_params)
        render json: current_user.school
      else
        render json: { errors: current_user.school.errors.full_messages }, status: :unprocessable_entity
      end
    end

    private

    def school_params
      params.require(:school).permit(:name, :location)
    end
  end
end
