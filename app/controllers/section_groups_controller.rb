class SectionGroupsController < ApplicationController
    before_action :require_login
    before_action :set_section_group, only: [:show, :edit, :update, :destroy, :delete, :leave]
    before_action :set_itinerary, only: [:new, :create]
  
    def index
      @section_groups = SectionGroup.all
    end
  
    def show
      @pilot = @section_group.user
      @members = @section_group.users
      @members_count = @section_group.users.count
      @section_group = SectionGroup.find(params[:id])
      @user = @section_group.user
    end
  
    def new
      @section_group = SectionGroup.new
      @places = Place.all
      if @itinerary
        @section_group.h_start = @itinerary.h_start
        @section_group.h_end = @itinerary.h_end
        @section_group.starting_place_id = @itinerary.starting_place_id
        @section_group.ending_place_id = @itinerary.ending_place_id
        @section_group.day = @itinerary.day
        @section_group.itinerary_id = @itinerary.id
      end
    end
  
    def create
      @section_group = SectionGroup.new(section_group_params)
      @section_group.user_id = current_user.id
      @places = Place.all
  
      if @itinerary
        @section_group.h_start = @itinerary.h_start
        @section_group.h_end = @itinerary.h_end
        @section_group.starting_place_id = @itinerary.starting_place_id
        @section_group.ending_place_id = @itinerary.ending_place_id
        @section_group.day = @itinerary.day
        @section_group.itinerary_id = @itinerary.id
      end
  
      if @section_group.save
        redirect_to viaje_path
        flash[:notice] = 'Viaje creado exitosamente.'
      else
        render :new
      end
    end
  
    def edit
    end
  
    def update
      if @section_group.update(section_group_params)
        redirect_to @section_group, notice: 'Viaje actualizado exitosamente.'
      else
        render :edit
      end
    end
  
    def destroy
      if @section_group.user_id == current_user.id
        @section_group.destroy
        redirect_to root_path, notice: 'Viaje eliminado exitosamente.'
      else
        redirect_to section_group_path(@section_group), alert: 'No tienes permiso para eliminar este viaje.'
      end
    end
  
    def delete
      @section_group = SectionGroup.find(params[:id])
      if @section_group.destroy
        flash[:success] = "Viaje eliminado exitosamente."
      else
        flash[:error] = "Error al eliminar el viaje."
      end
      redirect_to root_path
    end
  
    def leave
      if @section_group.users.include?(current_user)
        SectionGroupHistory.create(section_group: @section_group, user: current_user, action: 'Salir')
        @section_group.users.delete(current_user)
        redirect_to root_path, notice: 'Has salido del viaje exitosamente.'
      else
        redirect_to root_path, alert: 'No eres miembro de este viaje.'
      end
    end

  
    private
  
    def set_section_group
      @section_group = SectionGroup.find(params[:id])
    end
  
    def set_itinerary
      @itinerary = Itinerary.find_by(id: params[:itinerary_id])
    end
  
    def section_group_params
      params.require(:section_group).permit(:n_seats, :cost, :h_start, :h_end, :day, :starting_place_id, :ending_place_id, :user_id, :itinerary_id, :travel_date)
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
  end
  