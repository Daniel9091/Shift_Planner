class SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:user][:email])

    if user && user.authenticate(params[:user][:password])
      session[:user_id] = user.id

      if user.first_login?
        redirect_to change_password_path, notice: "¡Bienvenido! Por favor, cambia tu contraseña."
      else
        redirect_to root_path, notice: "Inicio de sesión exitoso"
      end
    else
      flash.now[:alert] = "Credenciales inválidas"
      render :login
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "Sesión cerrada correctamente"
  end

  def change_password
    @user = current_user
    render :change_password
  end
end
