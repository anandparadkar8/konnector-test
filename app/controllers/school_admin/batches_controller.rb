module SchoolAdmin
  class BatchesController < ApplicationController
    before_action :authorize_school_admin!
    before_action :set_batch, only: [:show, :update, :destroy, :add_student, :students]

    def index
      render json: current_user.school.batches
    end

    def show
      render json: @batch
    end

    def create
      batch = current_user.batches.build(batch_params)
      if batch.save
        render json: batch, status: :created
      else
        render json: { errors: batch.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def update
      if @batch.update(batch_params)
        render json: @batch
      else
        render json: { errors: @batch.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def destroy
      @batch.destroy
      head :no_content
    end

    # Add existing student to batch
    def add_student
      student = current_user.school.students.find(params[:student_id])
      enrollment = @batch.enrollment_requests.build(student: student, status: 'approved')
      if enrollment.save
        render json: enrollment
      else
        render json: { errors: enrollment.errors.full_messages }, status: :unprocessable_entity
      end
    end

    # List all students in batch
    def students
      render json: @batch.students
    end

    private

    def set_batch
      @batch = current_user.school.batches.find(params[:id])
    end

    def batch_params
      params.require(:batch).permit(:name, :course_id)
    end
  end
end
