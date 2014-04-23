class ElectedsUsersController < ApplicationController

  def create

    @user = current_user
    @elected = Elected.find(params[:elected_id])
    @user.electeds << @elected
    render json: @user.electeds
  end

  def destroy
    @user = current_user
    @elected = Elected.find(params[:elected_id])
    @user.electeds.delete(Elected.find_by(id: @elected.id))
    render json: @user.electeds
  end
end
