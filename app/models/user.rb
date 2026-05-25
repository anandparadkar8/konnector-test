class User < ApplicationRecord
  # Devise modules
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Associations
  belongs_to :school, optional: true
  has_many :courses, foreign_key: :creator_id, dependent: :destroy
  has_many :enrollment_requests, foreign_key: :student_id, dependent: :destroy

  # Roles
  validates :role, presence: true, inclusion: { in: %w[admin school_admin student] }

  # Validations
  validates :name, presence: true

   def admin?
    role == "admin"
  end

  def school_admin?
    role == "school_admin"
  end

  def student?
    role == "student"
  end
end
