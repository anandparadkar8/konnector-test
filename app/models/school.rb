# app/models/school.rb
class School < ApplicationRecord
  has_many :users, dependent: :destroy
  has_many :school_admins, -> { where(role: 'school_admin') }, class_name: 'User'
  has_many :students, -> { where(role: 'student') }, class_name: 'User'

  has_many :courses, dependent: :destroy
  has_many :batches, through: :courses
end
