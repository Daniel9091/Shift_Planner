class UsersController < ApplicationController
    def new
      @user = User.new
    end
  
    def create
      @user = User.new(user_params)
      @user.phone = "+56" + params[:user][:phone]
      if @user.save
        session[:user_id] = @user.id
        redirect_to root_path
      else
        flash.now[:alert] = "Error al registrar el usuario"
        render :new
      end
    end
    
    def show
      @user = User.find(params[:id])
      @itineraries = @user.itineraries.order(:day, :h_start).to_a.sort_by { |itinerary| [day_to_number(itinerary.day), itinerary.h_start] }
    end

    def update
      @user = User.find(params[:id])
      if @user.update(user_params)
        @user.update(first_login: false) if @user.first_login
        redirect_to root_path, notice: "Contraseña actualizada correctamente."
      else
        render :change_password
      end
    end
  
    private
  
    def user_params
      params.require(:user).permit(:name, :email, :password, :phone, :description, :data_name, :data_rut, :account_type, :n_account, :banc, :data_email, :first_login)
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
  