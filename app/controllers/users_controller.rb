class UsersController < ApplicationController
    def new
      @user = User.new
    end
  
    def create
      @user = User.new(user_params)
      if @user.save
        session[:user_id] = @user.id
        redirect_to root_path, notice: "Usuario registrado exitosamente"
      else
        flash.now[:alert] = "Error al registrar el usuario"
        render :new
      end
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
      params.require(:user).permit(:name, :email, :password, :phone, :description, :data)
    end
  end
  