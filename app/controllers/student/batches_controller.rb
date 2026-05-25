module Student
  class BatchesController < ApplicationController
    before_action :authorize_student!
    before_action :set_batch, only: [:students]

    def index
      render json: current_user.enrolled_batches
    end

    # View classmates
    def students
      render json: @batch.students
    end

    private

    def set_batch
      @batch = current_user.enrolled_batches.find(params[:id])
    end
  end
end
