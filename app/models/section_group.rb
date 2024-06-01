class SectionGroup < ApplicationRecord
  belongs_to :user
  belongs_to :starting_place, class_name: 'Place'
  belongs_to :ending_place, class_name: 'Place'
  belongs_to :itinerary
  # Validaciones
  validates :n_seats, presence: true
  validates :cost, presence: true
  validates :h_start, presence: true
  validates :h_end, presence: true
  validates :day, presence: true
end
  