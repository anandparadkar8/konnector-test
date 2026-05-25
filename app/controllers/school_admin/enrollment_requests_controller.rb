module SchoolAdmin
  class EnrollmentRequestsController < ApplicationController
    before_action :authorize_school_admin!
    before_action :set_request, only: [:approve, :deny]

    def index
      render json: EnrollmentRequest.joins(:batch).where(batches: { school_id: current_user.school.id })
    end

    def approve
      @request.update(status: 'approved')
      render json: @request
    end

    def deny
      @request.update(status: 'denied')
      render json: @request
    end

    private

    def set_request
      @request = EnrollmentRequest.find(params[:id])
      unless @request.batch.school_id == current_user.school.id
        render json: { error: 'Not authorized' }, status: :forbidden
      end
    end
  end
end
