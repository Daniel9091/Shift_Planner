class User < ApplicationRecord
    # Seguridad
    has_secure_password
    # Relaciones
    has_many :itineraries, dependent: :destroy
    has_many :section_groups, dependent: :destroy
    has_many :memberships, dependent: :destroy
    has_many :section_group, through: :memberships
    # Validaciones
    validates :name, presence: true
    validates :email, presence: true, uniqueness: true
    validates :phone, presence: true
    validates :password, confirmation: true, presence: true, on: :create
    validates :password_confirmation, presence: true, on: :create
    # Fuciones relevantes
    def average_driver_rating
        return 0 if n_driver_review.zero? driver_review.to_f / n_driver_review
    end
    
    def average_passenger_rating
        return 0 if n_passenger_review.zero? passenger_review.to_f / n_passenger_review
    end
end
