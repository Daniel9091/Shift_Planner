class HomeController < ApplicationController
  before_action :require_login
  helper_method :filter_groups  

  def index
    @user = current_user
    if @user
      @itineraries = @user.itineraries.to_a.sort_by { |itinerary| [day_to_number(itinerary.day), itinerary.h_start] }
    else
      @itineraries = []
    end
  end

  def viajes
    @user = current_user
    @pilot_trips = SectionGroup.where(user_id: @user.id) || []
    @passenger_trips = SectionGroup.joins(:memberships).where(memberships: { user_id: @user.id }) || []
  
    @pilot_trips = @pilot_trips.sort_by { |trip| [day_to_number(trip.day), trip.h_start] }
    @passenger_trips = @passenger_trips.sort_by { |trip| [day_to_number(trip.day), trip.h_start] }
  end

  def global
    @user = current_user
    @active_itineraries = @user.itineraries.where(is_active: true).sort_by { |itinerary| [day_to_number(itinerary.day), itinerary.h_start] }
    
    if params[:mode] == 'Llegada'
      @current_mode = 'Llegada'
      @new_mode = 'Salida'
      @button_text = 'Cambiar a modo Salida'
    else
      @current_mode = 'Salida'
      @new_mode = 'Llegada'
      @button_text = 'Cambiar a modo Llegada'
    end
  end

  def join_group
    @group = SectionGroup.find(params[:id])
    if @group.users.count >= @group.n_seats.to_i
      redirect_to global_path(mode: params[:mode]), alert: 'El grupo ya está lleno.'
    else
      @group.users << current_user
      SectionGroupHistory.create(section_group: @group, user: current_user, action: 'Entrar')
      redirect_to global_path(mode: params[:mode]), notice: 'Te has unido al grupo con éxito.'
    end
  end

  private

  def require_login
    redirect_to login_path, alert: 'Debes iniciar sesión para acceder a esta página' unless user_signed_in?
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def user_signed_in?
    !current_user.nil?
  end

  def filter_groups(itinerary, current_mode)
    if current_mode == 'Llegada'
      SectionGroup.where(h_end: itinerary.h_end, day: itinerary.day, starting_place_id: itinerary.starting_place_id, ending_place_id: itinerary.ending_place_id)
    else
      SectionGroup.where(h_start: itinerary.h_start, day: itinerary.day, starting_place_id: itinerary.starting_place_id, ending_place_id: itinerary.ending_place_id)
    end
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