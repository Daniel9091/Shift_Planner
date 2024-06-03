class SectionGroup < ApplicationRecord
  belongs_to :user
  belongs_to :starting_place, class_name: 'Place'
  belongs_to :ending_place, class_name: 'Place'
  belongs_to :itinerary

  has_many :section_group_histories, dependent: :destroy
  # Validaciones
  validates :n_seats, presence: true
  validates :cost, presence: true
  validates :h_start, presence: true
  validates :h_end, presence: true
  validates :day, presence: true
  validates :itinerary_id, presence: true
  validates :cost, presence: true, numericality: { only_integer: true, greater_than: 0 }
  has_many :memberships, dependent: :destroy
  validates :travel_date, presence: true
  has_many :users, through: :memberships
end
  