class ElectedsUsersController < ApplicationController
  
  def create
    session[:return_to] = request.referrer
    @user = User.find(session[:user_id])
    @elected = Elected.find(params[:elected_id])
    @user.electeds << @elected
    redirect_to session[:return_to]
  end

  def destroy
    session[:return_to] = request.referrer
    @user = User.find(session[:user_id])
    @elected = Elected.find(params[:id])
    @user.electeds.delete(Elected.find_by(id: @elected.id))

    redirect_to session[:return_to]
  end
end