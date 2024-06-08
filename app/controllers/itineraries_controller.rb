class ItinerariesController < ApplicationController
    before_action :require_login
    before_action :set_itinerary, only: [:toggle_active]

    def index
      @itineraries = Itinerary.all
      @itineraries = @itineraries.sort_by { |itinerary| [day_to_number(itinerary.day), itinerasry.h_start] }
    end

    def new
      @itinerary = Itinerary.new
      @places = Place.all
    end
  
    def create
      @itinerary = Itinerary.new(itinerary_params)
      @itinerary.user = current_user
  
      if @itinerary.save
        redirect_to root_path, notice: 'Itinerario creado exitosamente.'
      else
        @places = Place.all
        render :new
      end
    end

    def toggle_active
      @itinerary.update(is_active: !@itinerary.is_active)
      redirect_to request.referrer
    end

    def delete
      @itinerary = Itinerary.find(params[:id])
      if @itinerary.destroy
        flash[:notice] = "Itinerario eliminado exitosamente."
      else
        flash[:alert] = "Error al eliminar el itinerario."
      end
      redirect_to root_path  
    end
    
  
    private
  
    def itinerary_params
      params.require(:itinerary).permit(:status, :day, :h_start, :h_end, :starting_place_id, :ending_place_id)
    end
  
    def require_login
      redirect_to login_path, alert: 'Debes iniciar sesión para acceder a esta página' unless user_signed_in?
    end
  
    def current_user
      @current_user ||= User.find_by(id: session[:user_id])
    end
  
    def user_signed_in?
      !current_user.nil?
    end

    def set_itinerary
      @itinerary = Itinerary.find(params[:id])
    end

    def day_to_number(day)
      days = {
        "Lunes" => 1,
        "Martes" => 2,
        "Miércoles" => 3,
        "Jueves" => 4,
        "Viernes" => 5,
        "Sábado" => 6,
        "Domingo" => 7
      }
      days[day]
    end
  end