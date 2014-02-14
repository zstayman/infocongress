class ElectedsUsersController < ApplicationController
  
  def create
    @user = User.find(session[:user_id])
    @elected = Elected.find(params[:elected_id])
    @user.electeds << @elected
    redirect_to electeds_path
  end

  def destroy
    @user = User.find(session[:user_id])
    @elected = Elected.find(params[:id])
    @user.electeds.delete(Elected.find_by(id: @elected.id))

    redirect_to electeds_path
  end
end