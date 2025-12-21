# app/models/user.rb
class User < ApplicationRecord
  belongs_to :school, optional: true

  # Devise authentication
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: { admin: 'admin', school_admin: 'school_admin', student: 'student' }

  has_many :courses, foreign_key: :creator_id, dependent: :destroy, if: :school_admin?
  has_many :batches, foreign_key: :creator_id, dependent: :destroy, if: :school_admin?
  has_many :enrollment_requests, foreign_key: :student_id, dependent: :destroy, if: :student?
  has_many :enrolled_batches, through: :enrollment_requests, source: :batch

  validates :role, presence: true
  validates :school, presence: true, if: -> { school_admin? || student? }
end
