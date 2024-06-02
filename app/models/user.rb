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
    validates :password_digest, confirmation: true, presence: true, on: :create
    # Fuciones relevantes

    def update_password
        @user = User.find(params[:id])
        if @user.update(user_params)
          redirect_to root_path, notice: "Contraseña actualizada correctamente."
        else
          render :change_password
        end
    end

    def user_params
        params.require(:user).permit(:password_digest)
    end

    
    def average_driver_rating
        return 0 if n_driver_review.zero? driver_review.to_f / n_driver_review
    end
    
    def average_passenger_rating
        return 0 if n_passenger_review.zero? passenger_review.to_f / n_passenger_review
    end
end
