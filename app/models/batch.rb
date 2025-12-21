# app/models/batch.rb
class Batch < ApplicationRecord
  belongs_to :course
  belongs_to :creator, class_name: 'User', foreign_key: 'creator_id'

  has_many :enrollment_requests, dependent: :destroy
  has_many :students, through: :enrollment_requests, source: :student

  validates :name, presence: true
end
