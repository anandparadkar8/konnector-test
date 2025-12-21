# app/models/course.rb
class Course < ApplicationRecord
  belongs_to :school
  belongs_to :creator, class_name: 'User', foreign_key: 'creator_id'
  has_many :batches, dependent: :destroy

  validates :name, presence: true
end
