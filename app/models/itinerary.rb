class Itinerary < ApplicationRecord
  belongs_to :user
  belongs_to :starting_place, class_name: 'Place'
  belongs_to :ending_place, class_name: 'Place'
  has_many :section_groups, dependent: :destroy
  # Validaciones
  validates :status, presence: true
  validates :is_active, inclusion: { in: [true, false] }
  validates :day, presence: true
  validates :h_start, presence: true
  validates :h_end, presence: true

  def has_section_groups?
    section_groups.any?
  end
end