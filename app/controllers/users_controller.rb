class UsersController < ApplicationController
  before_action :user, only: [:show, :edit, :update, :destroy]
  before_action :authenticate, :authorize, except: [:new, :create]

  def new
    @user=User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id

      @user.follow_local_electeds

      redirect_to user_path(@user)
    else
      render(:new)
    end
  end

  def show
  end

  def edit
    render(:edit)
  end

  def update
    @update_worked = @user.update(user_params)
    binding.pry
    if @update_worked
      redirect_to user_path(@user)
    else
      render(:edit)
    end
  end

  def destroy
    @user.destroy
    session[:user_id] = nil
    redirect_to root_path
  end

  private
  
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :zip, :password, :password_confirmation, :password_digest)
  end

  def authenticate
    unless logged_in?
      redirect_to root_path
    end
  end

  def authorize
    unless current_user == @user
      redirect_to root_path
    end
  end

  def user
    @user=User.find(params[:id])
  end
end