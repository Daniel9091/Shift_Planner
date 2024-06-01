class Place < ApplicationRecord
  # Relaciones
  has_many :starting_itineraries, class_name: 'Itinerary', foreign_key: 'starting_place_id' , dependent: :destroy
  has_many :ending_itineraries,   class_name: 'Itinerary', foreign_key: 'ending_place_id'   , dependent: :destroy

  has_many :starting_section_groups,  class_name: 'SectionGroup', foreign_key: 'starting_place_id', dependent: :destroy
  has_many :ending_section_groups,    class_name: 'SectionGroup', foreign_key: 'ending_place_id',   dependent: :destroy
  # Validaciones
  validates :name, presence: true
end



  