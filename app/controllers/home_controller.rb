class HomeController < ApplicationController
  before_action :require_login
  helper_method :filter_groups  

  def index
    @user = current_user
    @itineraries = @user ? @user.itineraries : []
  end

  def viajes
    @user = current_user
    @pilot_trips = SectionGroup.where(user_id: @user.id) || []
    @passenger_trips = SectionGroup.joins(:memberships).where(memberships: { user_id: @user.id }) || []
  end

  def global
    @user = current_user
    @active_itineraries = @user.itineraries.where(is_active: true)
  
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
    if @group.users.count < @group.n_seats.to_i
      @group.users << current_user
      redirect_to global_path(mode: params[:mode]), notice: 'Te has unido al grupo con éxito.'
    else
      redirect_to global_path(mode: params[:mode]), alert: 'El grupo ya está lleno.'
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
end